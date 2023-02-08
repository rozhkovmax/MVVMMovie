// AlertDelegate.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол для алерта
protocol AlertDelegate: AnyObject {
    func showAlertController(error: Error)
}
