//
//  ExpensesTableView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class ExpensesList: UIView {
    
    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 46
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delaysContentTouches = false
        tableView.register(CategoryCell.self)
        return tableView
    }()
    
    // MARK: - Properties

    private var models = [CategoryCellModel]()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func setupView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    // MARK: - Updating
    
    func update(with items: [CategoryCellModel]) {
        self.models = items
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ExpensesList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(CategoryCell.self)
            .update(with: models[indexPath.row].viewModel)
    }
}

// MARK: - UITableViewDelegate

extension ExpensesList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        models[indexPath.row].onTap()
    }
}

struct CategoryCellModel {
    let viewModel: CategoryViewModel
    let onTap: VoidClosure
    
    init(viewModel: CategoryViewModel, _ onTap: @escaping VoidClosure) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
}
