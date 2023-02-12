// ListMovieViewModelTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование вью модели списка фильмов
final class ListMovieViewModelTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockString = "Baz"
    }
    
    // MARK: - Private Properties
    
    private let mockNetworkService = MockNetworkService()
    private let mockImageService = MockImageService()
    private let mockKeychainService = MockKeyChainService()
    private let mockCoreDataService = MockCoreDataService()
    private var listMovieViewModel: ListMovieViewModelProtocol?
    
    // MARK: - Public Methods
    
    override func setUp() {
        listMovieViewModel = ListMovieViewModel(networkService: mockNetworkService,
                                                imageService: mockImageService,
                                                keyChainService: mockKeychainService,
                                                coreDataService: mockCoreDataService)
    }
    
    override func tearDown() {
        listMovieViewModel = nil
    }
    
    func testSegmentControlAction() {
        listMovieViewModel?.segmentControlAction(index: 0)
        XCTAssertEqual(listMovieViewModel?.methodType, .upcomingMethod)
        listMovieViewModel?.segmentControlAction(index: 1)
        XCTAssertEqual(listMovieViewModel?.methodType, .popularMethod)
        listMovieViewModel?.segmentControlAction(index: 2)
        XCTAssertEqual(listMovieViewModel?.methodType, .topRatedMethod)
    }
    
    func testFetchMovies() {
        listMovieViewModel?.segmentControlAction(index: 0)
        switch listMovieViewModel?.listMovieProps {
        case .success(let result):
            XCTAssertEqual(result.count, 1)
        default:
            break
        }
    }
    
    func testFetchImage() {
        listMovieViewModel?.fetchImage(url: Constants.mockString) { result in
            XCTAssertEqual(result, Constants.mockString.data(using: .utf8))
        }
    }
    
    func testFetchMovie() {
        XCTAssertNoThrow(listMovieViewModel?.fetchMovies())
    }
}