//
//  DailyReviewList.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 09.09.2021.
//

import UIKit

class DailyReviewListView: UIView {

    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delaysContentTouches = false
        tableView.register(DailyReviewCell.self, HeaderAmountCell.self)
        return tableView
    }()

    // MARK: - Callbacks

    var onSelectDailyReview: ((ExpensesListViewState.Daily) -> Void)?

    // MARK: - State

    private var sections: [ExpensesListViewState.Section] = []

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Updating

    @discardableResult
    func update(with sections: [ExpensesListViewState.Section]) -> Self {
        self.sections = sections
        tableView.reloadData()
        return self
    }
}

// MARK: - UITableViewDataSource

extension DailyReviewListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.item]

        switch item {
        case .monthAmount(let amount):
            return tableView.dequeue(HeaderAmountCell.self).update(withAmount: amount)
        case .dailyExpenses(let expensesModel):
            return tableView.dequeue(DailyReviewCell.self).update(with: expensesModel)
        }
    }
}

// MARK: - UITableViewDelegate

extension DailyReviewListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = sections[indexPath.section].items[indexPath.item]

        switch item {
        case .monthAmount:
            return .automaticDimension
        case .dailyExpenses(let dailyModel):
            return Layout.dailyCategoryHeight * CGFloat(dailyModel.expenseCategories.count) + Layout.categoryHeight
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]

        switch item {
        case .monthAmount:
            break
        case .dailyExpenses(let daily):
            onSelectDailyReview?(daily)
        }
    }
}
