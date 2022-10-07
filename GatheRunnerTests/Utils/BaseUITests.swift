//
//  BaseUITests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/10/07.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import GatheRunner

// MARK: - DeviceModel

enum DeviceModel: String {
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhoneXsMax = "iPhone Xs Max"
    case iPhoneXr = "iPhone Xr"
    case iPhoneSe = "iPhone Se"

    // MARK: Internal

    var defauleConfig: ViewImageConfig {
        switch self {
        case .iPhone8: return ViewImageConfig.iPhone8
        case .iPhone8Plus: return ViewImageConfig.iPhone8Plus
        case .iPhoneX: return ViewImageConfig.iPhoneX
        case .iPhoneXsMax: return ViewImageConfig.iPhoneXsMax
        case .iPhoneXr: return ViewImageConfig.iPhoneXr
        case .iPhoneSe: return ViewImageConfig.iPhoneSe
        }
    }

    var portraitConfig: ViewImageConfig {
        switch self {
        case .iPhone8: return ViewImageConfig.iPhone8(.portrait)
        case .iPhone8Plus: return ViewImageConfig.iPhone8Plus(.portrait)
        case .iPhoneX: return ViewImageConfig.iPhoneX(.portrait)
        case .iPhoneXsMax: return ViewImageConfig.iPhoneXsMax(.portrait)
        case .iPhoneXr: return ViewImageConfig.iPhoneXr(.portrait)
        case .iPhoneSe: return ViewImageConfig.iPhoneSe(.portrait)
        }
    }
}

// MARK: - BaseUITestsProtocol

protocol BaseUITestsProtocol {
    var identity: String { get }
    var deviceModel: DeviceModel { get }
    var viewController: UIViewController { get }

    func test_view_on_iPhone() throws
    func test_view_on_iPhone_portrait() throws
    func test_view_verifySnapshot_defaultConfig() throws
}

// MARK: - BaseUITests

class BaseUITests: XCTestCase {

    // MARK: Internal

    var identity: String {
        fatalError()
    }

    var deviceModel: DeviceModel {
        fatalError()
    }

    var viewController: UIViewController {
        fatalError()
    }

    override func setUpWithError() throws {
        guard isModelMatching else {
            return assertionFailure(Message.modelMatchingFailed)
        }
    }

    func test_view_on_iPhone() throws {
        assertSnapshot(matching: viewController, as: .image(on: deviceModel.defauleConfig), named: fileName, record: false)
    }

    func test_view_on_iPhone_portrait() throws {
        assertSnapshot(
            matching: viewController,
            as: .image(on: deviceModel.portraitConfig),
            named: fileName + Config.landscape,
            record: false)
    }

    func test_view_verifySnapshot_defaultConfig() throws {
        let result = verifySnapshot(
            matching: viewController,
            as: .image(on: deviceModel.portraitConfig),
            named: fileName + Config.landscape,
            record: true)

        XCTAssertNil(result)
    }

    // MARK: Private

    private enum Config {
        static let landscape = "_landscape"
    }

    private enum Message {
        static let modelMatchingFailed = "스냅샷 테스트는 언제나 같은 디바이스에서 돌아가야 합니다"
    }

    private var isModelMatching: Bool {
        guard UIDevice.current.name == deviceModel.rawValue else {
            return false
        }
        return true
    }

    private var fileName: String {
        "\(identity)_\(deviceModel.rawValue)"
    }
}
