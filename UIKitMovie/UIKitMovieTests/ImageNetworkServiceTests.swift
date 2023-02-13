// ImageNetworkServiceTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование сервиса получения изображений
final class ImageNetworkServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockString = "Baz"
    }

    // MARK: - Private Properties

    private var imageNetworkService: ImageNetworkService?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        imageNetworkService = ImageNetworkService()
    }

    override func tearDown() {
        super.tearDown()
        imageNetworkService = nil
    }

    func testFetchImage() throws {
        imageNetworkService?.fetchImage(imagePath: Constants.mockString, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        })
    }
}
