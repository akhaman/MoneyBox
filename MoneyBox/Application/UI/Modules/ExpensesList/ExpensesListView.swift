//
//  ExpensesListView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 07.09.2021.
//

import UIKit
import SnapKit

class ExpensesListView: UIView {

    // MARK: - Subviews

    private lazy var infoView = InfoView()
    private lazy var list = DailyReviewListView()

    // MARK: - Callbacks

    var addExpenseTapped: VoidClosure? {
        get {
            infoView.onAddButtonDidTap
        }
        set {
            infoView.onAddButtonDidTap = newValue
        }
    }

    var onSelectDailyReview: ((ExpensesListViewState.Daily) -> Void)? {
        get {
            list.onSelectDailyReview
        }
        set {
            list.onSelectDailyReview = newValue
        }
    }

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Initial Configuration

    private func setupView() {
        let background = GradientView.mainBackground
        addSubview(background)
        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addSubview(list)
        list.snp.makeConstraints { $0.edges.equalToSuperview() }

        addSubview(infoView)
        infoView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Updating

    func update(state: ExpensesListViewState) {

        switch state {
        case .empty:
            infoView.show()
            list.hide()
        case .loaded(let sections):
            infoView.hide()
            list.show()
            list.update(with: sections)
        }
    }
}
