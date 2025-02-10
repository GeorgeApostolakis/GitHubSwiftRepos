//
//  File.swift
//  
//
//  Created by george.apostolakis on 09/02/25.
//

import CoreTestSupport
import SwiftUI
import XCTest

@testable import Components

final class DSScreenViewTests: XCTestCase {
    func test_givenErrorState_whenBuildingView_thenAssertCorrectSnapshoot() throws {
        // given
        let screenState: Binding<ScreenState> = .constant(.error(.connection(nil)))
        let content = Image
            .emptyImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        // when
        let sut = DSScreenView(state: screenState, content: { content })
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenLoadingState_whenBuildingView_thenAssertCorrectSnapshoot() throws {
        // given
        let screenState: Binding<ScreenState> = .constant(.loading)
        let content = Image
            .emptyImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        // when
        let sut = DSScreenView(state: screenState, content: { content })
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }

    func test_givenContentState_whenBuildingView_thenAssertCorrectSnapshoot() throws {
        // given
        let screenState: Binding<ScreenState> = .constant(.content)
        let content = Image
            .emptyImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        // when
        let sut = DSScreenView(state: screenState, content: { content })
        // then
        try assertSnapShoot(matching: sut.embeddedInView())
    }
}
