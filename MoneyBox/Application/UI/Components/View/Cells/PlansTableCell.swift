//
//  PlansTableCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

class PlansTableCell: UITableViewCell {
    // MARK: - UI

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Layout.planSize
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlanCell.self)

        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return collectionView
    }()

    // MARK: - Properties

    private var planModels: [PlanCellModel] = []

    // MARK: - Updating

    @discardableResult
    func update(with models: [PlanCellModel]) -> Self {
        planModels = models
        collectionView.reloadData()
        return self
    }
}

// MARK: - UICollectionViewDataSource

extension PlansTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        planModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeue(PlanCell.self, for: indexPath)
            .update(with: planModels[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegate

extension PlansTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        planModels[indexPath.row].onTap()
    }
}
