//
//  RunningRecordViewUITests.swift
//  GatheRunnerUITests
//
//  Created by 김동현 on 2022/08/19.
//

import SwiftUI
import XCTest

class RunningRecordViewUITests: XCTestCase {
    var app: XCUIApplication!
    var moveButton: XCUIElement!
    var runStartButton: XCUIElement!
    var onOffButton: XCUIElement!
    var timerView: XCUIElement!
    var delay: XCTestExpectation!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]

        moveButton = app.buttons["moveButton"]
        runStartButton = app.buttons["runStartButton"]
        onOffButton = app.switches["resumeButton"]
        timerView = app.staticTexts["timerView"]

        app.launch()
    }

    func test_onOffToggle_shouldOperationTimer_withFirstTap() {
        print(#function)

        moveButton.tap()
        runStartButton.tap()
        onOffButton.tap()

        delay = XCTestExpectation()
        delay.isInverted = true
        wait(for: [delay], timeout: 2)
        XCTAssertNotEqual(timerView.label, "00 : 00")
    }

    func test_onOffToggle_shouldStopTimer_withSecondTap() {
        print(#function)

        moveButton.tap()
        runStartButton.tap()
        onOffButton.doubleTap()

        delay = XCTestExpectation()
        delay.isInverted = true
        wait(for: [delay], timeout: 2)
        XCTAssertEqual(timerView.label, "00 : 00")
    }

    func test_onOffToggle_shouldOperationTimer_onBackGround() {
        print(#function)

        moveButton.tap()
        runStartButton.tap()
        onOffButton.tap()
        XCUIDevice().press(XCUIDevice.Button.home)
        sleep(3)
        app.activate()
        XCTAssertNotEqual(timerView.label, "00 : 00")
    }
}
