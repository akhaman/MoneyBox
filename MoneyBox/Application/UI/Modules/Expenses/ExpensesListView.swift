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

    // MARK: - UI

    private lazy var infoView = InfoView(
        image: Image.Info.donation.image,
        message: "У вас пока нет расходов",
        button: .init(title: "добавить") { [weak self] in self?.addExpenseTapped?() }
    )

    private lazy var dailyList = DailyReviewListView()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        GradientView.mainBackground.apply(to: self)
        addSubview(infoView)
        infoView.snp.makeConstraints { $0.edges.equalToSuperview() }
        addSubview(dailyList)
        dailyList.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Updating

    func update(with sections: [HomeListSection] = []) {
        if sections.isEmpty {
            infoView.show()
            dailyList.hide()
        } else {
            infoView.hide()
            dailyList.show()
            dailyList.update(with: sections)
        }
    }
}
