//
//  ContentView.swift
//  Weather App
//
//  Created by Student on 5/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var apiData: String = "Placeholder"
    
    var body: some View {
        Text(apiData)
            .task {
                let urlstring: String = ""
            }
    }
}

#Preview {
    ContentView()
}
