//
//  GitHubPullRequestsView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 10/02/25.
//

import Components
import SwiftUI

struct GitHubPullRequestsView: View {
    @ObservedObject var viewModel: GitHubViewModel

    var body: some View {
        Text("Some Text")
            .toolbar {
                ToolbarItem {
                    HStack {
                        Image
                            .pullRequestIcon
                            .resizable()
                            .frame(width: 25, height: 25)
                        DSText(AppStrings.PullRequests.title)
                    }
                }
            }
    }
}
