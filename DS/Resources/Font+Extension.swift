//
//  UIFont+Extension.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI


public extension Font {
    enum FontTypes {
        case body
        case title
        case subtitle
        case largeTitle
    }

    static func dsFont(type: FontTypes) -> Font {
        switch type {
        case .body: return .body
        case .title: return .title
        case .subtitle: return .subheadline
        case .largeTitle: return .largeTitle
        }
    }
}
