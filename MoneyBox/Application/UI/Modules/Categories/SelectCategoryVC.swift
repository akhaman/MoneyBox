//
//  SelectCategoryVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

protocol SelectCategoryModule: Presentable {
    
    var onSelectCategory: ((Categories.Id) -> Void)? { get set }
}

enum Categories {
    typealias Id = String
}

class SelectCategoryVC: UIViewController, SelectCategoryModule {

    var onSelectCategory: ((Categories.Id) -> Void)?
    
    private let cateogriesView = SelectCategoryView()
    
    // MARK: - Life Cycle

    override func loadView() {
        view = cateogriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "Категории"
        cateogriesView.update(with: models)
    }
    
    private var models: [CategoryCollectionCellModel] {
        [
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {}),
            .init(icon: Image.Category.agreement.image, title: "Заголовок", onTap: {})
        ]
    }
}
