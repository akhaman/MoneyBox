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
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textColor = Colors.unselected.color
        
        contentView.addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Updating

    @discardableResult
    func update(with text: String) -> Self {
        titleLabel.text = text
        return self
    }
}
