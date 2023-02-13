// DetailMovieViewModelTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование вью модели описания фильма
final class DetailMovieViewModelTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockString = "Bar"
    }

    // MARK: - Private Properties

    private let film: MovieData? = nil
    private let mockImageService = MockImageService()
    private var detailMovieViewModel: DetailMovieViewModelProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        detailMovieViewModel = DetailMovieViewModel(
            film: film,
            imageService: mockImageService
        )
    }

    override func tearDown() {
        super.tearDown()
        detailMovieViewModel = nil
    }

    func testFetchImage() {
        detailMovieViewModel?.fetchImage(url: Constants.mockString) { result in
            XCTAssertEqual(result, Constants.mockString.data(using: .utf8))
        }
    }
}
