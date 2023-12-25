//
//  CreditsView.swift
//  Notes-WatchOS Watch App
//
//  Created by Drashti on 20/12/23.
//

import SwiftUI

struct CreditsView: View {
    // MARK: - Properties
    @State private var randomNumber: Int = Int.random(in: 1..<4)
    
    private var randomImage: String{
        return "developer-no\(randomNumber)"
    }
    // MARK: - Body
    var body: some View {
        VStack(spacing: 3, content: {
            // profile image
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            // header
            HeaderView(title: "Credits")
            // content
            Text("Pratik Pandya")
                .foregroundStyle(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fontWeight(.light)
        })// VStack
    }
}

#Preview {
    CreditsView()
}
