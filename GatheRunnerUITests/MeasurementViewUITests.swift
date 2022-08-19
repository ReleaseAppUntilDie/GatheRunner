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

    func testOnOff() {
        app.buttons["ButtonTest"].tap()
        app.buttons["runStartButton"].tap()
        app.switches["onOffButton"].tap()

        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: 2)
        let timerView = app.staticTexts["timerView"]
        XCTAssertNotEqual(timerView.label, "00 : 00")
    }

    func testStop() {
        app.buttons["ButtonTest"].tap()
        app.buttons["runStartButton"].tap()
        app.switches["onOffButton"].doubleTap()

        let testStopDelay = XCTestExpectation()
        testStopDelay.isInverted = true
        wait(for: [testStopDelay], timeout: 2)
        let timerView = app.staticTexts["timerView"]
        XCTAssertEqual(timerView.label, "00 : 00")
    }

}
