// AssemblyBuilderTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование сборщика экранов
final class AssemblyBuilderTests: XCTestCase {
    // MARK: - Private Properties
    
    private var assemblyBuilder: AssemblyBuilderProtocol?
    
    // MARK: - Public Methods
    
    override func setUp() {
        assemblyBuilder = AssemblyBuilder()
    }

    override func tearDown() {
        assemblyBuilder = nil
    }

    func testMakeListMovieModule() {
        let listMovieModule = assemblyBuilder?.makeListMovieModule()
        XCTAssertTrue(listMovieModule is ListMovieViewController)
    }
}
