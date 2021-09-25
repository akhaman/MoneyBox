//
//  InfoView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit
import SnapKit

class InfoView: UIView {
    // MARK: - UI

    private lazy var imageView = UIImageView()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = Colors.unselected.color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var messageButton = MessageButton()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(image: UIImage, message: String, button: ButtonModel? = nil) {
        self.init()
        configure(image: image, message: message, button: button)
    }

    // MARK: - Confuguration

    func configure(image: UIImage, message: String, button: ButtonModel? = nil) {
        imageView.image = image
        messageLabel.text = message

        button.ifPresent {
            messageButton.show().configure(with: $0)
        } orElse: {
            messageButton.hide()
        }
    }

    // MARK: - Helpers

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
