//
//  Settings.swift
//  Notes-WatchOS Watch App
//
//  Created by Drashti on 21/12/23.
//

import SwiftUI

struct Settings: View {
    // MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    // MARK: - Functions
    
    func update(){
        lineCount = Int(value)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing:8){
            // Header
            HeaderView(title: "Settings")
            // Actual line count
            Text("Lines \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            // Slider
            Slider(value: Binding(get: {
                self.value
            }, set: { (newValue) in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .tint(.accent)
        }// VStack
    }
}

#Preview {
    Settings()
}
