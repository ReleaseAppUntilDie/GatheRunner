//
//  RunningRecordViewUITests.swift
//  GatheRunnerUITests
//
//  Created by 김동현 on 2022/08/19.
//

import SwiftUI
import XCTest
@testable import GatheRunner

class RunningRecordViewUITests: XCTestCase {

    // MARK: Internal

    var app: XCUIApplication!
    var moveButton: XCUIElement!
    var runStartButton: XCUIElement!
    var onOffButton: XCUIElement!
    var timerView: XCUIElement!
    var delay: XCTestExpectation!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = [SettingValue.launchArguments]

        moveButton = app.buttons["moveButton"]
        runStartButton = app.buttons["runStartButton"]
        onOffButton = app.switches[SubViews.RunningRecord.resumeButton]
        timerView = app.staticTexts[SubViews.RunningRecord.timerView]
        app.launch()
    }

    func test_onOffToggle_shouldOperationTimer_withFirstTap() {
        print(#function)

        moveButton.tap()
        runStartButton.tap()
        onOffButton.tap()

        delay = XCTestExpectation()
        delay.isInverted = true
        wait(for: [delay], timeout: SettingValue.timeout)
        XCTAssertNotEqual(timerView.label, Result.timerLabel)
    }

    func test_onOffToggle_shouldStopTimer_withSecondTap() {
        print(#function)

        moveButton.tap()
        runStartButton.tap()
        onOffButton.doubleTap()

        delay = XCTestExpectation()
        delay.isInverted = true
        wait(for: [delay], timeout: SettingValue.timeout)
        XCTAssertEqual(timerView.label, Result.timerLabel)
    }

    func test_onOffToggle_shouldOperationTimer_onBackGround() {
        print(#function)

        moveButton.tap()
        runStartButton.tap()
        onOffButton.tap()
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(SettingValue.sleepTime)
        app.activate()
        XCTAssertNotEqual(timerView.label, Result.timerLabel)
    }

    // MARK: Private

    private enum Result {
        static let timerLabel = "00 : 00"
    }

    private enum SettingValue {
        static let launchArguments = "testing"
        static let timeout: Double = 2
        static let sleepTime: UInt32 = 3
    }
}
