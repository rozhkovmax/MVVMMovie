// FileServiceTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование файл менеджера
final class FileServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockString = "Bar"
        static let mockNumber = 1
    }

    // MARK: - Private Properties

    private var fileService: FileServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        fileService = FileService()
    }

    override func tearDown() {
        super.tearDown()
        fileService = nil
    }

    func testFileService() {
        let mockData = Data(count: Constants.mockNumber)
        fileService?.saveImageToCache(url: Constants.mockString, data: mockData)
        let data = fileService?.getImageFromCache(url: Constants.mockString)
        XCTAssertEqual(mockData, data)
    }
}
