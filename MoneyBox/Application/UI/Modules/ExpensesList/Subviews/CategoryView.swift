//
//  CategoryView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class CategoryView: UIView {
    
    // MARK: - UI

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = Colors.selected.color
        return label
    }()

    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = Colors.selected.color
        return label
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Updating

    @discardableResult
    func update(with model: ExpensesListViewState.Category) -> Self {
        iconImageView.image = model.icon
        titleLabel.text = model.title
        sumLabel.text = model.sumAmount + "₽"
        return self
    }

    func update(icon: UIImage, title: String, sumAmount: String) {
        iconImageView.image = icon
        titleLabel.text = title
        sumLabel.text = sumAmount + "₽"
    }

    // MARK: - Helpers

    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, sumLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { $0.size.equalTo(22) }
    }
}
