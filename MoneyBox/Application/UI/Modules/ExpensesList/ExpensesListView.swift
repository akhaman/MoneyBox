//
//  ExpensesListView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 07.09.2021.
//

import UIKit
import SnapKit

class ExpensesListView: UIView {
    
    // MARK: - Callbacks

    var addExpenseTapped: VoidClosure?

    // MARK: - Subviews

    private lazy var infoView = InfoView(
        image: Image.Info.donation.image,
        message: "У вас пока нет расходов",
        button: .init(title: "добавить") { [weak self] in self?.addExpenseTapped?() }
    )

    private lazy var list = DailyReviewListView()
    // MARK: - State

    private var sections: [ExpensesListViewState.Section] = []

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

        if state.isEmpty {
            infoView.show()
            list.hide()
        } else {
            infoView.hide()
            list.show()
            list.update(with: state.sections)
        }
    }
}
