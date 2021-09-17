//
//  PlanCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

struct PlanCellModel {
    let iconImage: UIImage
    let title: String
    let onTap: VoidClosure
}

class PlanCell: CardCollectionCell {
    
    // MARK: - UI
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = Colors.selected.color
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 3
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardView.addSubview(stackView)
        stackView.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Updating
    
    @discardableResult
    func update(with model: PlanCellModel) -> Self {
        iconImageView.image = model.iconImage
        titleLabel.text = model.title
        return self
    }
}
