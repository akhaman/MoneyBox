//
//  ExpenseDetailsVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 25.09.2021.
//

import UIKit

final class ExpenseDetailsVC: UIViewController {
    
    var onExpenseCreated: VoidClosure?
    private let category: Expense.Category
    private let manager: ExpenseDetailsManagerProtocol
    
    private lazy var detailsView = ExpenseDetailsView()

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
    }

    // MARK: - Setting Up View

    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.Icon.close.image,
            style: .plain,
            target: self,
            action: #selector(closeButtonDidTap)
        )

        detailsView.onDoneButtonTapped = { [weak self] output in
            guard let self = self else { return }
            let expense = Expense.new(category: self.category, sum: output.sum, comment: output.comment)
            self.manager.save(expense: expense)
            self.dismiss(animated: true)
        }
    }

    @objc private func closeButtonDidTap() {
        dismiss(animated: true)
    }
}
