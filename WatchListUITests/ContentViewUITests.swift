//
//  ContentViewUITests.swift
//  WatchListUITests
//
//  Created by lucas.igarashi on 30/10/25.
//

import XCTest

final class ContentViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        // Ativa o seed automático na ContentView
        app.launchArguments += ["-UI_TEST_SEED", "1"]
        app.launch()
    }

    // MARK: - Helpers

    /// Abre o sheet "Novo Filme" e tenta detectar por identifier/heurísticas.
    func openNewMovieSheet() {
        let newMovieButton = app.buttons["NewMovieButton"].exists
            ? app.buttons["NewMovieButton"]
            : app.buttons["New Movie"]

        XCTAssertTrue(newMovieButton.waitForExistence(timeout: 5.0))
        newMovieButton.tap()

        if app.otherElements["NewMovieFormView"].waitForExistence(timeout: 3.0) {
            return
        }

        if app.sheets.firstMatch.waitForExistence(timeout: 2.0) { return }

        let anyField = app.textFields.element(boundBy: 0)
        XCTAssertTrue(anyField.waitForExistence(timeout: 3.0),
                      "Sheet não detectado. Verifique se NewMovieFormView tem accessibilityIdentifier(\"NewMovieFormView\").")
    }

    func revealSwipeActions(on cell: XCUIElement) {
        cell.swipeLeft()

        if !cell.buttons["SwipeDeleteButton"].waitForExistence(timeout: 1.5)
           && !cell.buttons["Delete"].waitForExistence(timeout: 1.0) {

            let start = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.90, dy: 0.5))
            let end   = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.10, dy: 0.5))
            start.press(forDuration: 0.1, thenDragTo: end)
        }
    }

    // MARK: - Tests

    func test_newMovieSheet_presents() {
        openNewMovieSheet()
    }

    func test_randomMovie_alertAppears_whenTwoOrMoreItems() {
        let randomButton = app.buttons["RandomMovieButton"].exists
            ? app.buttons["RandomMovieButton"]
            : app.buttons["Random Movie"]

        XCTAssertTrue(randomButton.waitForExistence(timeout: 5.0))
        randomButton.tap()

        let okButton = app.alerts.element.buttons["OK"]
        XCTAssertTrue(okButton.waitForExistence(timeout: 5.0))
        okButton.tap()
    }

}
