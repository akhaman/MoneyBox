//
//  TextCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

class HeaderAmountCell: UITableViewCell {

    // MARK: - UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = Colors.secondaryText.color
        label.text = "Всего"
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16))
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Updating

    @discardableResult
    func update(withAmount amount: String) -> Self {
        titleLabel.attributedText = (amount + "₽").attributed
            .with(font: .systemFont(ofSize: 34, weight: .medium))
            .with(color: Colors.primaryText.color)
            .with(color: Colors.secondaryText.color, substring: "₽")

        return self
    }
}
