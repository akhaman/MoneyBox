//
//  ExpenseDetailsVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 25.09.2021.
//

import UIKit

final class ExpenseDetailsVC: UIViewController {

    // MARK: - Dependencies

    private let category: Expense.Category
    private let manager: ExpenseDetailsManagerProtocol

    // MARK: - Subviews

    private lazy var detailsView = ExpenseDetailsView()

    // MARK: - Initialization

    init(category: Expense.Category, manager: ExpenseDetailsManagerProtocol) {
        self.category = category
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDataObservation()
        manager.loadState()
    }

    // MARK: - Setting Up View

    private func setupView() {
        configureTitleView()

        if isPresentedController {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: Image.Icon.close.image,
                style: .plain,
                target: self,
                action: #selector(closeModule)
            )
        }

        detailsView.onDoneButtonTapped = { [weak self] output in
            guard let self = self else { return }
            self.manager.save(output: output)
            self.closeModule()
        }
    }

    private func configureTitleView() {
        let label = UILabel()
        label.text = category.name
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = Colors.primaryText.color

        let imageView = UIImageView(image: category.icon)

        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .horizontal
        stack.spacing = 8

        navigationItem.titleView = stack
    }

    private func setupDataObservation() {
        manager.observe { [weak self] in self?.detailsView.update(withState: $0) }
    }

    // MARK: - Navigation

    @objc private func closeModule() {
        if isPresentedController {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
