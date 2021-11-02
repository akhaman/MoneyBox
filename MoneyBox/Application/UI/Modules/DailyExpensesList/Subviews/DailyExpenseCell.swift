//
//  DailyExpenseCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 02.11.2021.
//

import UIKit

class DailyExpenseCell: CardTableCell {

    // MARK: - Subviews

    private lazy var dailyExpenseView = CategoryView()

    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = Colors.primaryText.color
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initial Configuration

    private func setup() {
        let stack = UIStackView(dailyExpenseView, commentLabel)
            .axis(.vertical)
            .spacing(8)

        cardView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }

    // MARK: - Updating

    @discardableResult
    func update(with model: DailyExpensesListItem.Expense) -> Self {
        dailyExpenseView.update(icon: model.icon, title: model.name, sumAmount: model.sumAmount)
        commentLabel.text = model.comment
        return self
    }
}
