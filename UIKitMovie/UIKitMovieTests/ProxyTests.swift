// ProxyTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование прокси
final class ProxyTests: XCTestCase {
    // MARK: - Private Constants
    
    private enum Constants {
        static let mockString = "Foo"
    }
    
    // MARK: - Private Properties
    
    private let mockImageNetworkService = MockImageNetworkService()
    private let mockFileService = MockFileService()
    private var proxy: ProxyProtocol?
    
    // MARK: - Public Methods
    
    override func setUp() {
        proxy = Proxy(imageNetworkService: mockImageNetworkService, fileService: mockFileService)
    }
    
    override func tearDown() {
        proxy = nil
    }
    
    func testLoadImage() throws {
        proxy?.loadImage(url: Constants.mockString, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        })
    }
}
