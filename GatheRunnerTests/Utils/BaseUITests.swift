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

// MARK: - BaseUITests

class BaseUITests: XCTestCase {

    // MARK: Internal

    /// Inherited classes must be overridden Computed Properties.
    ///
    /// - Computed Properties:
    ///   - identity: Use for filename creating a snapshot.
    ///   - targetModel: Use for size creating a snapshot.
    ///   - isRecord: Whether or not to record a new reference.
    ///   - targetView: Use for view creating a snapshot.

    var identity: ViewIdentity {
        fatalError()
    }

    var targetModel: DeviceModel {
        fatalError()
    }

    var targetView: UIViewController {
        fatalError()
    }

    var isRecord: Bool {
        fatalError()
    }

    override func setUpWithError() throws {
        XCTAssertTrue(isModelMatching, Message.modelMatchingFailed)
    }

    /// For example, Inherited classes call test_view methods.
    ///          override func test_view_on_iPhone() throws {
    ///             try super.test_view_on_iPhone()
    ///          }

    func test_view_on_iPhone() throws {
        try requestSnapshotTasks(targetModel.defauleConfig, fileName: fileName)
    }

    func test_view_on_iPhone_landscape() throws {
        try requestSnapshotTasks(targetModel.landscapeConfig, fileName: fileName + Config.landscape)
    }

    // MARK: Private

    private enum Config {
        static let landscape = "_landscape"
    }

    private enum Message {
        static let modelMatchingFailed = "스냅샷 테스트는 언제나 같은 디바이스에서 돌아가야 합니다"
    }

    private var isModelMatching: Bool {
        guard UIDevice.current.name == targetModel.rawValue else {
            return false
        }
        return true
    }

    private var fileName: String {
        "\(identity.rawValue)_\(targetModel.rawValue)"
    }

    private func requestSnapshotTasks(_ config: ViewImageConfig, fileName: String) throws {
        guard isRecord else {
            return assertSnapshot(
                matching: targetView,
                as: .image(on: config),
                named: fileName,
                record: false)
        }

        /// The generated snapshot file is stored in under GatheRunnerTests/utils/__Snapshots__/BaseUITests.

        let result = verifySnapshot(
            matching: targetView,
            as: .image(on: config),
            named: fileName,
            record: true)

        try XCTSkipIf(true, result)
    }
}

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

    var landscapeConfig: ViewImageConfig {
        switch self {
        case .iPhone8: return ViewImageConfig.iPhone8(.landscape)
        case .iPhone8Plus: return ViewImageConfig.iPhone8Plus(.landscape)
        case .iPhoneX: return ViewImageConfig.iPhoneX(.landscape)
        case .iPhoneXsMax: return ViewImageConfig.iPhoneXsMax(.landscape)
        case .iPhoneXr: return ViewImageConfig.iPhoneXr(.landscape)
        case .iPhoneSe: return ViewImageConfig.iPhoneSe(.landscape)
        }
    }
}

// MARK: - ViewIdentity

enum ViewIdentity: String {
    case home = "Home"
    case authentication = "Authentication"
    case running = "Running"
    case activity = "Activity"

}

// MARK: - BaseUITestsProtocol

protocol BaseUITestsProtocol {
    var identity: ViewIdentity { get }
    var targetModel: DeviceModel { get }
    var targetView: UIViewController { get }
    var isRecord: Bool { get }

    func test_view_on_iPhone() throws
    func test_view_on_iPhone_landscape() throws
}
