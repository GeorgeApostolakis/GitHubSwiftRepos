//
//  SnapShootTesting.swift
//
//
//  Created by george.apostolakis on 08/02/25.
//

import XCTest
import SnapshotTesting
import SwiftUI

public extension XCTestCase {
    /// Verifies that a given view matches a reference snap shoot on disk.
    ///
    /// - Parameters:
    ///   - value: A value to compare against a reference.
    ///   - precision: the level of precision to be matched from 0 to 1
    ///   - record: Whether or not to record a new reference.
    func assertSnapShoot(
        matching value: @autoclosure () -> some View,
        precision: Float = 0.95,
        file filePath: StaticString = #file,
        line: UInt = #line,
        testName: String = #function,
        record: Bool = false
    ) throws {
        guard let wrapperView = UIHostingController(rootView: value()).view else {
            fatalError("Could not load SwiftUI View into UIHostingController")
        }

        let fileName = URL(fileURLWithPath: "\(filePath)", isDirectory: false)
            .lastPathComponent
            .replacingOccurrences(of: ".swift", with: "")

        let name = "\(fileName)_\(testName)"

        wrapperView.backgroundColor = .clear

        assertSnapshots(
            of: wrapperView,
            as: [
                .image(
                    perceptualPrecision: precision,
                    size: wrapperView.intrinsicContentSize
                )
            ],
            record: record,
            file: filePath,
            testName: name,
            line: line
        )
    }
}
