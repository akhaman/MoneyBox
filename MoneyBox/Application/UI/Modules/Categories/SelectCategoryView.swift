//
//  SelectCategoryView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

struct CategoryCollectionCellModel {
    let icon: UIImage
    let title: String
    let onTap: VoidClosure
}

class SelectCategoryView: UIView {
    
    // MARK: - UI
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Layout.categoryCollectionItemSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 0
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionCell.self)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var models = [CategoryCollectionCellModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        GradientView.secondaryBackground.apply(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Updating
    
    @discardableResult
    func update(with models: [CategoryCollectionCellModel]) -> Self {
        self.models = models
        collectionView.reloadData()
        return self
    }
}

// MARK: - UICollectionViewDataSource

extension SelectCategoryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeue(CategoryCollectionCell.self, for: indexPath)
            .update(with: models[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegate

extension SelectCategoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        models[indexPath.row].onTap()
    }
}
