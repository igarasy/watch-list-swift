//
//  ContentViewUITests.swift
//  WatchListUITests
//
//  Created by lucas.igarashi on 30/10/25.
//

import XCTest

final class ContentViewUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func test_newMovieSheet_presents() {
        let app = XCUIApplication()
        app.launch()

        let newMovieButton = app.buttons["New Movie"]
        XCTAssertTrue(newMovieButton.waitForExistence(timeout: 2.0))
        newMovieButton.tap()

        let anyField = app.textFields.element(boundBy: 0)
        XCTAssertTrue(anyField.waitForExistence(timeout: 2.0))
    }

    func test_randomMovie_alertAppears_whenTwoOrMoreItems() {
        let app = XCUIApplication()
        app.launch()

        let randomButton = app.buttons["Random Movie"]
        if randomButton.waitForExistence(timeout: 2.0) {
            randomButton.tap()

            let okButton = app.alerts.element.buttons["OK"]
            XCTAssertTrue(okButton.waitForExistence(timeout: 2.0))
            okButton.tap()
        } else {
            XCTFail("Random Movie button not found. Seed at least two movies for this test.")
        }
    }

    func test_swipeToDelete_rowDisappears() {
        let app = XCUIApplication()
        app.launch()

        let firstCell = app.tables.cells.element(boundBy: 0)
        if firstCell.waitForExistence(timeout: 2.0) {
            // Swipe para esquerda e toca "Delete"
            firstCell.swipeLeft()
            let delete = firstCell.buttons["Delete"]
            if delete.exists {
                delete.tap()
                XCTAssertFalse(firstCell.exists, "First cell should be deleted")
            } else {
                XCTFail("Delete button not found on swipe actions.")
            }
        } else {
            XCTFail("No table rows to delete. Seed a movie before running this test.")
        }
    }
}
