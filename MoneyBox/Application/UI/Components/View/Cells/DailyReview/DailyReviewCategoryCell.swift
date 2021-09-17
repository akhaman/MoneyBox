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
        contentView.addSubview(view)
        view.snp.makeConstraints { $0.edges.equalToSuperview() }
        return view
    }()
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    @discardableResult
    func update(with model: CategoryViewModel) -> Self {
        categoryView.update(with: model)
        return self
    }
}
