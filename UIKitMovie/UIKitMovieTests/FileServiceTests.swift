// FileServiceTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование файл менеджера
final class FileServiceTests: XCTestCase {
    // MARK: - Private Constants
    
    private enum Constants {
        static let mockString = "Bar"
    }
    
    // MARK: - Private Properties
    
    private var fileService: FileServiceProtocol?
    
    // MARK: - Public Methods
    
    override func setUp() {
        fileService = FileService()
    }
    
    override func tearDown() {
        fileService = nil
    }
    
    func testFileService() {
        let mockData = Data(count: 1)
        fileService?.saveImageToCache(url: Constants.mockString, data: mockData)
        let data = fileService?.getImageFromCache(url: Constants.mockString)
        XCTAssertEqual(mockData, data)
    }
}
