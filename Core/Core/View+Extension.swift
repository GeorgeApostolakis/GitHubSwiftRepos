//
//  File.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    func embeddedInView() -> some View {
        frame(width: 360, height: 800)
            .background(Color.gray)
    }
}
