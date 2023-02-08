// NSMutableAttributedString+Extension.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Расширение для изменения строки
extension NSMutableAttributedString {
    var boldFont: UIFont { UIFont.boldSystemFont(ofSize: 18) }
    var systemFont: UIFont { UIFont.systemFont(ofSize: 18) }

    func bold(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normal(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: systemFont,
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
