//
//  ExpenseDetailsView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 25.09.2021.
//

import UIKit

struct ExpenseDetailsViewOutput {
    let sum: Int
    let comment: String

    init?(sum: String?, comment: String?)  {
        guard let sum = sum,
              let intSum = Int(sum),
              let comment = comment else { return nil }

        self.sum = intSum
        self.comment = comment
    }
}

final class ExpenseDetailsView: UIView {

    // MARK: - Callbacks

    var onDoneButtonTapped: ((_ output: ExpenseDetailsViewOutput) -> Void)?

    // MARK: - Subviews

    private lazy var dateDescriptionLabel: UILabel = descriptionLabel(withText: "Дата:")
    private lazy var dateValueLabel: UILabel = descriptionLabel(withText: "cегодня")
    private lazy var sumLabel: UILabel = descriptionLabel(withText: "Сумма:")
    private lazy var commentLabel: UILabel = descriptionLabel(withText: "Комментарий:")
    private lazy var commentTextField: UITextField = textField(withPlaceholder: "введите заметку")
    private lazy var sumTextField: UITextField = textField(withPlaceholder: "введите сумму")

    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 41, bottom: 9, right: 41)
        button.setTitle("ГОТОВО", for: .normal)
        button.setTitleColor(Colors.primaryText.color, for: .normal)
        button.backgroundColor = Colors.gradientedBg2End.color
        button.isEnabled = false
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView methods

    override func layoutSubviews() {
        super.layoutSubviews()
        sumTextField.layer.cornerRadius = sumTextField.frame.height / 2
        commentTextField.layer.cornerRadius = commentTextField.frame.height / 2
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }

    // MARK: - Initial Configuration

    private func setup() {
        backgroundColor = .white

        let contentStack = UIStackView(arrangedSubviews: [
            horizontalStack(with: dateDescriptionLabel, dateValueLabel),
            horizontalStack(with: sumLabel, sumTextField),
            horizontalStack(with: commentLabel, commentTextField)
        ])
        contentStack.axis = .vertical
        contentStack.spacing = 22
        contentStack.alignment = .leading

        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(33)
            $0.centerX.equalToSuperview()
        }
    }

    private func horizontalStack(with subviews: UIView...) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }

    private func descriptionLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = Colors.primaryText.color
        return label
    }

    private func textField(withPlaceholder placeholder: String) -> UITextField {
        let field = TextFieldWithInsets()
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Colors.secondaryText.color,
                .font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ]
        )
        field.backgroundColor = Colors.placeholder.color
        field.layer.borderColor = Colors.separator.color.cgColor
        field.layer.borderWidth = 1
        field.layer.masksToBounds = true
        field.textInsets = UIEdgeInsets(top: 5, left: 12, bottom: 7, right: 12)
        field.addTarget(self, action: #selector(textFieldsValuesChanged), for: .editingChanged)
        return field
    }

    @objc private func buttonDidTap() {
        guard let output = ExpenseDetailsViewOutput(sum: sumTextField.text, comment: commentTextField.text) else { return }
        onDoneButtonTapped?(output)
    }

    @objc private func textFieldsValuesChanged() {
        doneButton.isEnabled = sumTextField.hasText && commentTextField.hasText
    }
}