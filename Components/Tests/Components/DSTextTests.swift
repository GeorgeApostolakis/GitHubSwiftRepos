//
//  DSTextTests.swift
//  
//
//  Created by george.apostolakis on 08/02/25.
//

import Core
import CoreTestSupport
import XCTest

@testable import Components

final class DSTextTests: XCTestCase {
    private let defaultString = "Some one line string!"

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
}
