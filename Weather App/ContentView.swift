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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Olaf")
        }
        .padding()
#Preview {
    ContentView()
}
