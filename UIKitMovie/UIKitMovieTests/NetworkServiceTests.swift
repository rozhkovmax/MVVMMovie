// NetworkServiceTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование сетевого сервиса
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let moviesCount = 20
    }

    // MARK: - Private Properties

    private let mockKeyChainService = MockKeyChainService()
    private var networkService: NetworkServiceProtocol?
    private var movies: ResultsMovie?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        networkService = NetworkService(keyChainService: mockKeyChainService)
    }

    override func tearDown() {
        super.tearDown()
        networkService = nil
    }

    func testFetchMovies() {
        networkService?.fetchMovies(method: .upcomingMethod, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(success):
                self.movies = success
                XCTAssertEqual(self.movies?.movies.count, Constants.moviesCount)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        })
    }
}
