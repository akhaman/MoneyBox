//
//  CategoryCollectionCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    // MARK: - UI

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.selected.color
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 7
        return stack
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.snp.makeConstraints { $0.size.equalTo(Layout.categoryCollectionItemImageSize) }
        contentView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Updating

    @discardableResult
    func update(with model: CategoryCollectionCellModel) -> Self {
        imageView.image = model.icon
        titleLabel.text = model.title
        return self
    }
}
