//
//  SelectCategoryVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

class SelectCategoryVC: UIViewController {

    private let categoriesView = SelectCategoryView()

    // MARK: - Life Cycle

    override func loadView() {
        view = categoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Категории"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.Icon.close.image,
            style: .plain,
            target: self,
            action: #selector(close)
        )

        categoriesView.update(with: categoryViewModels(from: Expense.Category.allCases))
    }

    private func categoryViewModels(from categories: [Expense.Category]) -> [CategoryCollectionCellModel] {
        categories.map { category in
            CategoryCollectionCellModel(from: category) { [weak self] in
                self?.openExpenseDetails(withCategory: category)
            }
        }
    }

    // MARK: - Navigation

    private func openExpenseDetails(withCategory category: Expense.Category) {
        let expenseDetailsVC = ExpenseDetailsVC(category: category, manager: ExpenseDetailsManager())
        navigationController?.pushViewController(expenseDetailsVC, animated: true)
    }

    @objc private func close() {
        dismiss(animated: true)
    }
}

extension CategoryCollectionCellModel {
    init(from category: Expense.Category, onSelect: @escaping VoidClosure) {
        self.init(icon: category.icon, title: category.name, onTap: onSelect)
    }
}
