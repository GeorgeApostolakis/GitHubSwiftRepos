//
//  DSErrorViewTests.swift
//
//
//  Created by george.apostolakis on 08/02/25.
//

import Core
import CoreTestSupport
import SwiftUI
import XCTest

@testable import Components

final class DSErrorViewTests: XCTestCase {
    private let defaultString = "Some one line string!"

    func test_givenGenericError_whenBuildingView_thenAssertSnapshoot() throws {
        let someImage = Image(systemName: "questionmark.text.page")
        let someText = "Some description to a Generic Error"
        let sut = DSErrorView(errorModel: .generic(someImage, someText))
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenGenericErrorAndRetryAction_whenBuildingView_thenAssertSnapshoot() throws {
        let someImage = Image(systemName: "questionmark.text.page")
        let someText = "Some description to a Generic Error"
        let sut = DSErrorView(errorModel: .generic(someImage, someText), retryAction: {})
        try assertSnapShoot(matching: sut.embeddedInView())
    }
}

