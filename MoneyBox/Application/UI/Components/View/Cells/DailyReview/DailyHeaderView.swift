//
//  DailyHeaderView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 09.09.2021.
//

import UIKit

class DailyHeaderView: UIView {
    
    // MARK: - UI

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = Colors.unselected.color
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = Colors.unselected.color
        return label
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        addSubview(amountLabel)
        amountLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(date: String, amount: String) {
        self.init(frame: .zero)
        update(date: date, amount: amount)
    }
    
    // MARK: - Updating
    
    @discardableResult
    func update(date: String, amount: String) -> Self {
        dateLabel.text = date
        amountLabel.text = date
        return self
    }
}
