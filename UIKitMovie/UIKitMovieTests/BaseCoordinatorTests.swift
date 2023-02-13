// BaseCoordinatorTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

@testable import UIKitMovie

import XCTest

/// Тестирование координатора
final class BaseCoordinatorTests: XCTestCase {
    // MARK: - Private Properties

    private let mockCoordinator = MockCoordinator()
    private var baseCoordinator: BaseCoordinator?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        baseCoordinator = BaseCoordinator()
    }

    override func tearDown() {
        super.tearDown()
        baseCoordinator = nil
    }

    func testAddDependency() {
        baseCoordinator?.addDependency(mockCoordinator)
        XCTAssertTrue(baseCoordinator?.childCoordinators.first === mockCoordinator)
    }

    func testRemoveDependency() {
        baseCoordinator?.addDependency(mockCoordinator)
        baseCoordinator?.removeDependency(mockCoordinator)
        guard let childCoordinators = baseCoordinator?.childCoordinators else { return }
        XCTAssertTrue(childCoordinators.isEmpty)
    }
}
