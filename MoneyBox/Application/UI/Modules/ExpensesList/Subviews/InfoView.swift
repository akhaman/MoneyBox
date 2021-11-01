//
//  InfoView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit
import SnapKit

class InfoView: UIView {

    // MARK: - Callbacks

    var onAddButtonDidTap: VoidClosure?

    // MARK: - UI

    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: Image.Info.donation.image)
        return view
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас пока нет расходов"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = Colors.unselected.color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("добавить", for: .normal)
        button.setTitleColor(Colors.primaryText.color, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    @objc private func buttonDidTap() {
        onAddButtonDidTap?()
    }

    private func setupView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }

        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(52)
        }

        addSubview(messageButton)
        messageButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
