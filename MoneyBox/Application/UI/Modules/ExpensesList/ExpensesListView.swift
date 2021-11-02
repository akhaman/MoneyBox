//
//  ExpensesTableView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class ExpensesListView: UIView {
    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.rowHeight = 46
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delaysContentTouches = false
        tableView.register(CategoryCell.self)
        return tableView
    }()

    // MARK: - Properties

    private var models: [ExpensesListViewState.Category] = []

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

    func update(with items: [ExpensesListViewState.Category]) {
        self.models = items
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ExpensesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(CategoryCell.self).update(with: models[indexPath.row])
    }
}
