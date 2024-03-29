//
//  DailyReviewCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 09.09.2021.
//

import UIKit
import SnapKit

extension DailyReviewCell {
    private class NotSelectableTableView: UITableView {
        override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            false
        }
    }
}

class DailyReviewCell: CardTableCell {
    
    // MARK: - UI

    private lazy var headerView = DailyHeaderView(frame: CGRect(height: Layout.dailyHeaderHeight))

    private lazy var tableView: UITableView = {
        let tableView = NotSelectableTableView()
        tableView.dataSource = self
        tableView.rowHeight = Layout.dailyCategoryHeight
        tableView.separatorStyle = .none
        tableView.register(DailyReviewCategoryCell.self)
        tableView.tableHeaderView = headerView
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        return tableView
    }()

    // MARK: - Properties

    private var expensesModels: [ExpensesListViewState.Category] = []

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cardView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Updating

    @discardableResult
    func update(with model: ExpensesListViewState.Daily) -> Self {
        headerView.update(date: model.stringDate, amount: model.amount)
        self.expensesModels = model.expenseCategories
        tableView.reloadData()
        return self
    }
}

// MARK: - UITableViewDataSource

extension DailyReviewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expensesModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(DailyReviewCategoryCell.self).update(with: expensesModels[indexPath.row])
    }
}
