// CustomLabel.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Расширение для добавления отступов
final class CustomLabel: UILabel {
    // MARK: - Private Properties

    private var insets = UIEdgeInsets.zero

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        return contentSize
    }

    // MARK: - Public Methods

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    func padding(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        frame = CGRect(x: 0, y: 0, width: frame.width + left + right, height: frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
