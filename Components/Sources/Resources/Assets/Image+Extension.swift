//
//  File.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

extension Image {
    static var negativeFeedback = Image(systemName: "x.circle")
    static var emptyImage = Image(systemName: "photo")
    static var noConnection = Image(systemName: "wifi.slash")
    static var badRequest = Image(systemName: "person.fill.questionmark")
}

#Preview {
    HStack(spacing: 10) {
        Image.negativeFeedback
            .resizable()
            .frame(width: 40, height: 40)
        Image.emptyImage
            .resizable()
            .frame(width: 40, height: 40)
        Image.noConnection
            .resizable()
            .frame(width: 40, height: 40)
        Image.badRequest
            .resizable()
            .frame(width: 40, height: 40)
    }
}
