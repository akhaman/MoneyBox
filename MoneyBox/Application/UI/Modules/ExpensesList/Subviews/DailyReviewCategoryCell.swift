//
//  DailyReviewCategoryCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

class DailyReviewCategoryCell: UITableViewCell {

    private lazy var categoryView: CategoryView = {
        let view = CategoryView()
        return view
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(categoryView)
        categoryView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    @discardableResult
    func update(with model: ExpensesListViewState.Category) -> Self {
        categoryView.update(with: model)
        return self
    }
}
