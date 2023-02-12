// UIKitMovieUITests.swift
// Copyright © Rozhkov M.N. All rights reserved.

import XCTest

/// UI-тест
final class UIKitMovieUITests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let listMovieTableViewAccessibilityID = "MovieAccessibilityID"
        static let listMovieCellAccessibilityID = "cellNumber_"
        static let listMovieCellNumber = "2"
        static let listMovieSegmentControlUpcomingItems = "В прокате"
        static let listMovieSegmentControlPopularItems = "Популярное"
        static let listMovieSegmentControlTopRatedItems = "Топ рейтинга"
        static let backToList = "К списку"
    }

    // MARK: - Private Properties

    private let application = XCUIApplication()

    // MARK: - Public Methods

    override func setUp() {
        continueAfterFailure = false
        application.launch()
    }

    func testMovie() {
        application.segmentedControls.buttons[Constants.listMovieSegmentControlPopularItems].tap()
        application.swipeUp()
        application.swipeDown()
        application.segmentedControls.buttons[Constants.listMovieSegmentControlTopRatedItems].tap()
        let movieTable = application.tables.matching(identifier: Constants.listMovieTableViewAccessibilityID)
        movieTable.element.swipeUp()
        movieTable.element.swipeDown()
        let cell = movieTable.cells.element(
            matching: .cell,
            identifier: "\(Constants.listMovieCellAccessibilityID)\(Constants.listMovieCellNumber)"
        )
        cell.tap()
        application.swipeUp()
        application.swipeDown()
        application.navigationBars.buttons[Constants.backToList].tap()
        application.segmentedControls.buttons[Constants.listMovieSegmentControlUpcomingItems].tap()
        movieTable.element.swipeUp()
    }
}
