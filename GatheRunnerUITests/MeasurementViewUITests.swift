//
//  MeasurementViewUITests.swift
//  GatheRunnerUITests
//
//  Created by 김동현 on 2022/08/19.
//

import XCTest

class MeasurementViewUITests: XCTestCase {
    var app: XCUIApplication!


    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }

    func test_onOffToggle_shouldOperationTimer_withFirstTap() {
        app.buttons["moveButton"].tap()
        app.buttons["runStartButton"].tap()
        app.switches["onOffButton"].tap()

        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: 2)
        let timerView = app.staticTexts["timerView"]
        XCTAssertNotEqual(timerView.label, "00 : 00")
    }

    func test_onOffToggle_shouldStopTimer_withSecondTap() {
        app.buttons["moveButton"].tap()
        app.buttons["runStartButton"].tap()
        app.switches["onOffButton"].doubleTap()

        let testStopDelay = XCTestExpectation()
        testStopDelay.isInverted = true
        wait(for: [testStopDelay], timeout: 2)
        let timerView = app.staticTexts["timerView"]
        XCTAssertEqual(timerView.label, "00 : 00")
    }

    func test_onOffToggle_shouldOperationTimer_onBackGround() {
        app.buttons["moveButton"].tap()
        app.buttons["runStartButton"].tap()
        app.switches["onOffButton"].tap()
        XCUIDevice().press(XCUIDevice.Button.home)
        sleep(3)
        app.activate()
        let timerView = app.staticTexts["timerView"]
        XCTAssertNotEqual(timerView.label, "00 : 00")
    }
}
