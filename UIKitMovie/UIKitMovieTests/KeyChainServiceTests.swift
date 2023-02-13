// KeyChainServiceTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование сервиса для сохранения критических данных
final class KeyChainServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockKey = "Bar"
        static let mockKeyValue = "Foo"
    }

    // MARK: - Private Properties

    private var keyChainService: KeyChainServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        keyChainService = KeyChainService()
    }

    override func tearDown() {
        keyChainService = nil
    }

    func testKeychainService() {
        let mockValue = Constants.mockKeyValue
        keyChainService?.saveAPIKey(mockValue, forKey: Constants.mockKey)
        let catchMockValue = keyChainService?.getAPIKey(Constants.mockKey)
        XCTAssertNotNil(catchMockValue)
        XCTAssertEqual(mockValue, catchMockValue)
    }
}
