//
//  Fonts.swift
//  Components
//
//  Created by george.apostolakis on 04/02/25.
//

import Foundation
import UIKit

enum DSFontFactory {
    static func large() -> UIFont {
        .init(name: "Roboto", size: 20) ?? .init()
    }
}
