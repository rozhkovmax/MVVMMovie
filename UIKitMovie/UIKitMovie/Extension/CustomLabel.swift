// CustomLabel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Добавляем отсутпы в Label
final class CustomLabel: UILabel {
    // MARK: - Private Properties

    private var insets = UIEdgeInsets.zero

    // MARK: - Life Cycle

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        return contentSize
    }

    // MARK: - Public Methods

    func padding(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        frame = CGRect(x: 0, y: 0, width: frame.width + left + right, height: frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
