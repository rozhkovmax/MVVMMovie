// NetworkServiceTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование сетевого сервиса
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Properties
    
    private let mockKeyChainService = MockKeyChainService()
    private var networkService: NetworkServiceProtocol?
    private var movies: ResultsMovie?
    
    // MARK: - Public Methods
    
    override func setUp() {
        networkService = NetworkService(keyChainService: mockKeyChainService)
    }
    
    override func tearDown() {
        networkService = nil
    }
    
    func testFetchMovies() {
        networkService?.fetchMovies(method: .upcomingMethod, completion: { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(success):
                self.movies = success
                XCTAssertEqual(self.movies?.movies.count, 20)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        })
    }
}
