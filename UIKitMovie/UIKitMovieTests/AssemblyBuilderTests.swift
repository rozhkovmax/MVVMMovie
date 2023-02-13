// AssemblyBuilderTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import CoreData
import XCTest

/// Тестирование сборщика экранов
final class AssemblyBuilderTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockContextName = "MovieDataModel"
        static let mockEntityName = "MovieData"
    }

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

    func testMakeDetailMovieModule() {
        let mockContext = NSPersistentContainer(name: Constants.mockContextName).viewContext
        guard let mockEntity = NSEntityDescription.entity(forEntityName: Constants.mockEntityName, in: mockContext)
        else { return }
        let mockMovieData = MovieData(entity: mockEntity, insertInto: mockContext)
        let detailMovieModule = assemblyBuilder?.makeDetailMovieModule(movie: mockMovieData)
        XCTAssertTrue(detailMovieModule is DetailMovieViewController)
    }
}
