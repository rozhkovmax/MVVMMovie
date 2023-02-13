// UIKitMovieUITestsLaunchTests.swift
// Copyright © Rozhkov M.N. All rights reserved.

import XCTest

/// UI-тесты
final class UIKitMovieUITestsLaunchTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let attachmentName = "Launch Screen"
    }

    // MARK: - Public Properties

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = Constants.attachmentName
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
