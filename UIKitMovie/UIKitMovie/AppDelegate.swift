// AppDelegate.swift
// Copyright © Rozhkov M.N. All rights reserved.

import CoreData
import UIKit

/// AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Private Constants

    private enum Constants {
        static let fatalErrorText = "Критическая ошибка"
        static let coreDataModelName = "MovieData"
    }

    // MARK: - Public Properties

    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError(
                "\(Constants.fatalErrorText) \(String(describing: UIApplication.shared.delegate))"
            )
        }
        return delegate
    }()

    lazy var coreDataService: CoreDataService = .init(modelName: Constants.coreDataModelName)
}
