//
//  CategoryCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class CategoryCell: CardTableCell {
    // MARK: - UI

    private lazy var categoryView: CategoryView = {
        let view = CategoryView()
        cardView.addSubview(view)
        view.snp.makeConstraints { $0.edges.equalToSuperview() }
        return view
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
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
