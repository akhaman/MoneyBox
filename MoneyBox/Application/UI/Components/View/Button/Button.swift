//
//  Button.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class Button: UIButton {
    
    // MARK: - Properties

    private var onTap: VoidClosure?
    
    var title: String {
        get {
            titleLabel?.text ?? ""
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, _ onTap: @escaping VoidClosure) {
        self.init(frame: .zero)
        configure(withTitle: title, onTap)
    }
    
    // MARK: - Confiugartors

    @discardableResult
    func configure(with model: ButtonModel) -> Self {
        configure(withTitle: model.title, model.onTap)
    }
    
    @discardableResult
    func configure(withTitle title: String, _ onTap: @escaping VoidClosure) -> Self {
        self.title = title
        self.onTap = onTap
        return self
    }
    
    // MARK: - Helpers

    private func setupView() {
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        onTap?()
    }
}

struct ButtonModel {
    let title: String
    let onTap: () -> Void
}
