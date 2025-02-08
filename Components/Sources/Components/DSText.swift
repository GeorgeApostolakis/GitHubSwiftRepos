//
//  File.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

struct DSText: View {

    private let string: String

    init(string: String = "") {
        self.string = string
    }

    var body: some View {
        Text(string)
            .font(.dsFonts(.body))
    }
}

#Preview {
    DSText(string: "Something to put in a label")
}
