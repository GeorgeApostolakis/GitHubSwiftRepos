//
//  AssetsList.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 10/02/25.
//

import SwiftUI

extension Image {
    static var forkIcon = Image("forkIcon")
    static var starIcon = Image("starIcon")
    static var githubIcon = Image("githubIcon")
    static var pullRequestIcon = Image("pullRequestIcon")
}

#Preview {
    VStack {
        Image.forkIcon.resizable().frame(width: 50, height: 50)
        Image.starIcon.resizable().frame(width: 50, height: 50)
        Image.githubIcon.resizable().frame(width: 50, height: 50)
        Image.pullRequestIcon.resizable().frame(width: 50, height: 50)
    }
}
