//
//  DSErrorViewTests.swift
//
//
//  Created by george.apostolakis on 08/02/25.
//

import CoreTestSupport
import SwiftUI
import XCTest

@testable import Components

final class DSErrorViewTests: XCTestCase {
    private let defaultString = "Some one line string!"
    // MARK: - Generic Error
    func test_givenGenericError_whenBuildingView_thenAssertSnapshoot() throws {
        // given
        let someImage = Image(systemName: "questionmark.text.page")
        let someText = "Some description to a Generic Error"
        let error = DSErrorView.Model.generic(someImage, someText, nil)
        // when
        let sut = DSErrorView(errorModel: error)
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenGenericErrorAndRetryAction_whenBuildingView_thenAssertSnapshoot() throws {
        // given
        let someImage = Image(systemName: "questionmark.text.page")
        let someText = "Some description to a Generic Error"
        let error = DSErrorView.Model.generic(someImage, someText, {})
        // when
        let sut = DSErrorView(errorModel: error)
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    // MARK: - BadRequest Error
    func test_givenBadRequestErrorAndRetryAction_whenBuildingView_thenAssertSnapshoot() throws {
        // given
        let someText = "Some description to a Generic Error"
        let error = DSErrorView.Model.badRequest(someText, {})
        // when
        let sut = DSErrorView(errorModel: error)
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenBadRequestError_whenBuildingView_thenAssertSnapshoot() throws {
        // given
        let someText = "Some description to a Bad Request Error"
        let error = DSErrorView.Model.badRequest(someText, nil)
        // when
        let sut = DSErrorView(errorModel: error)
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    // MARK: - ConnectionError
    func test_givenConnectionError_whenBuildingView_thenAssertSnapshoot() throws {
        // given
        let error = DSErrorView.Model.connection(nil)
        // when
        let sut = DSErrorView(errorModel: error)
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenConnectionErrorAndRetryAction_whenBuildingView_thenAssertSnapshoot() throws {
        // given
        let error = DSErrorView.Model.connection({ })
        // when
        let sut = DSErrorView(errorModel: error)
        //then
        try assertSnapShoot(matching: sut.embeddedInView())
    }
}
