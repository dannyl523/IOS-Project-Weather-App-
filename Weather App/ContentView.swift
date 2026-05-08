//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Student on 5/1/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Weather")
            Text(viewModel.weatherText)
                .padding()
        }
        .onAppear {
            viewModel.fetchWeather(for: "New York City")
        }
    }
}


#Preview {
    ContentView()
}
