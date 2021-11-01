//
//  CardTableCell.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit
import SnapKit

class CardTableCell: UITableViewCell {
    // MARK: - UI

    lazy var cardView = CardView()

    var insets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16) {
        didSet {
            cardView.snp.remakeConstraints { $0.edges.equalToSuperview().inset(insets) }
        }
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview().inset(insets) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        cardView.set(highlighted: highlighted)
    }

    // MARK: - Updating

    @discardableResult
    func insets(_ insets: UIEdgeInsets) -> Self {
        self.insets = insets
        return self
    }

    @discardableResult
    func insets(
        top: CGFloat? = nil,
        left: CGFloat? = nil,
        bottom: CGFloat? = nil,
        right: CGFloat? = nil
    ) -> Self {
        var insets = self.insets

        top.map { insets.top = $0 }
        left.map { insets.left = $0 }
        bottom.map { insets.bottom = $0 }
        right.map { insets.right = $0 }

        self.insets = insets
        return self
    }

    @discardableResult
    func enableAnimations() -> Self {
        cardView.enableAnimations()
        return self
    }

    @discardableResult
    func disableAnimations() -> Self {
        cardView.disableAnimations()
        return self
    }

    @discardableResult
    func enableShadows() -> Self {
        cardView.enableShadows()
        return self
    }

    @discardableResult
    func disableShadows() -> Self {
        cardView.disableShadows()
        return self
    }
}
