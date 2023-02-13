// MockCoreDataService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

@testable import UIKitMovie

/// Мок сервиса базы данных
final class MockCoreDataService: CoreDataServiceProtocol {
    // MARK: - Public Properties

    var errorCoreDataAlert: AlertHandler?
    var movie: [MovieData] = []

    // MARK: - Public Methods

    func saveData(movies: [Movie], moviesType: MethodType) {}
    func getData(moviesType: MethodType) -> [MovieData] {
        movie
    }
}
