//
//  DailyReviewCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 09.09.2021.
//

import UIKit
import SnapKit

struct DailyReviewModel {
    let date: String
    let amount: String
    let expenses: [CategoryViewModel]
    let onTap: VoidClosure
}

class DailyReviewCell: CardTableCell {

    // MARK: - UI

    private lazy var headerView = DailyHeaderView(frame: CGRect(height: Layout.dailyHeaderHeight))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.rowHeight = Layout.dailyCategoryHeight
        tableView.separatorStyle = .none
        tableView.register(DailyReviewCategoryCell.self)
        tableView.tableHeaderView = headerView
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        cardView.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return tableView
    }()
        
    // MARK: - Properties
    
    private var expensesModels = [CategoryViewModel]()
    
    // MARK: - Updating
    
    @discardableResult
    func update(with model: DailyReviewModel) -> Self {
        headerView.update(date: model.date, amount: model.amount)
        self.expensesModels = model.expenses
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
