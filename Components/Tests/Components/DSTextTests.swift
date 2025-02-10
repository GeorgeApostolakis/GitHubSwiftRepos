//
//  DSTextTests.swift
//  
//
//  Created by george.apostolakis on 08/02/25.
//

import CoreTestSupport
import SwiftUI
import XCTest

@testable import Components

final class DSTextTests: XCTestCase {
    private let defaultString = "Some one line string!"

    // MARK: - Color primary
    func test_givenBodyFont_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenHeaderFont_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .header)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenTitleFont_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .title)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSubTitleFont_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .subtitle)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSmallFont_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .small)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    // MARK: - Color reverColor
    func test_givenBodyFontAndReverseColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, textColor: .reverseColor)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenHeaderFontAndReverseColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .header, textColor: .reverseColor)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenTitleFontAndReverseColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .title, textColor: .reverseColor)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSubTitleFontAndReverseColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .subtitle, textColor: .reverseColor)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSmallFontAndReverseColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .small, textColor: .reverseColor)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    // MARK: - Color contrast
    func test_givenBodyFontAndContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, textColor: .contrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenHeaderFontAndContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .header, textColor: .contrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenTitleFontAndContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .title, textColor: .contrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSubTitleFontAndContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .subtitle, textColor: .contrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSmallFontAndContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .small, textColor: .contrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    // MARK: - Color lightContrast
    func test_givenBodyFontAndLightContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, textColor: .lightContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenHeaderFontAndLightContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .header, textColor: .lightContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenTitleFontAndLightContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .title, textColor: .lightContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSubTitleFontAndLightContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .subtitle, textColor: .lightContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSmallFontAndLightContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .small, textColor: .lightContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    // MARK: - Color darkContrast
    func test_givenBodyFontAndDarkContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, textColor: .darkContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenHeaderFontAndDarkContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .header, textColor: .darkContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenTitleFontAndDarkContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .title, textColor: .darkContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSubTitleFontAndDarkContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .subtitle, textColor: .darkContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSmallFontAndDarkContrastColor_whenBuildingView_thenAssertSnapshoot() throws {
        let sut = DSText(defaultString, variant: .small, textColor: .darkContrast)
        try assertSnapShoot(matching: sut.embeddedInView())
    }
}
