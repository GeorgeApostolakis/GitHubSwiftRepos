//
//  DSButtonTests.swift
//
//
//  Created by george.apostolakis on 09/02/25.
//

import CoreTestSupport
import SwiftUI
import XCTest

@testable import Components

final class DSButtonTests: XCTestCase {
    func test_givenDefaultConfig_whenBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "Fill") {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSizeHeader_whenBuildingButtonthenAssertSnapshoot() throws {
        let sut = DSButton(title: "Fill Header", size: .header) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenSizeSmall_whenBBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "Fill Small", size: .small) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenVariantText_whenBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "Text", variant: .text) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenVariantTextSizeHeader_whenBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "Text Header", variant: .text, size: .header) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenVariantTextSizeSmall_whenBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "Text Small", variant: .text, size: .small) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenIsLoading_whenBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "isLoading", isLoading: .constant(true)) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenIsDisable_whenBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "isDisable and Fill", isDisable: .constant(true)) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenVariantTextIsDisable_whenBuildingButton_thenAssertSnapshoot() throws {
        let sut = DSButton(title: "isDisable and Text", variant: .text, isDisable: .constant(true)) {}
        try assertSnapShoot(matching: sut.embeddedInView())
    }
}
