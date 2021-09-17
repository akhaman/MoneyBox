//
//  DailyReviewList.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 09.09.2021.
//

import UIKit

typealias HomeListSection = Section<HomeListRowModel>

enum HomeListRowModel {
    case monthAmount(String)
    case plans([PlanCellModel])
    case dailyExpenses(DailyReviewModel)
}

class DailyReviewListView: UIView {
    
    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delaysContentTouches = false
        tableView.register(DailyReviewCell.self, HeaderAmountCell.self, PlansTableCell.self)
        
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return tableView
    }()
    
    // MARK: - Properties
    
    private var sections = [HomeListSection]()
    
    // MARK: - Updating

    @discardableResult
    func update(with sections: [HomeListSection]) -> Self {
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
        let cell: UITableViewCell
        
        switch item {
        case .monthAmount(let amount):
            cell = tableView.dequeue(HeaderAmountCell.self).update(with: amount)
        case .plans(let planModels):
            cell = tableView.dequeue(PlansTableCell.self).update(with: planModels)
        case .dailyExpenses(let expensesModel):
            cell = tableView.dequeue(DailyReviewCell.self).update(with: expensesModel)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DailyReviewListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.item]
        switch item {
        case .monthAmount, .plans:
            break
        case .dailyExpenses(let expensesModel):
            expensesModel.onTap()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = sections[indexPath.section].items[indexPath.item]
        
        switch item {
        case .monthAmount:
            return .automaticDimension
        case .plans:
            return .zero
        case .dailyExpenses(let dailyModel):
            return Layout.dailyCategoryHeight * CGFloat(dailyModel.expenses.count) + Layout.categoryHeight
        }
    }
}
