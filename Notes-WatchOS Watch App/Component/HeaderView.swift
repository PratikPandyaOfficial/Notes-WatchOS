//
//  HeaderView.swift
//  Notes-WatchOS Watch App
//
//  Created by Drashti on 20/12/23.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties
    var title: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack {
            // title
            if title != ""{
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
            }
            // seperator
            HStack{
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            } // HStack
            .foregroundStyle(.accent)
        }// VStack
    }
}

#Preview {
    HeaderView(title: "Credits")
}
