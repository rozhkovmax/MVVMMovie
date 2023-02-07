// AlertDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для алерта
protocol AlertDelegate: AnyObject {
    func showAlertController(error: Error)
}
