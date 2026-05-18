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
        VStack(spacing: 20) {
            Text("Weather")
                .font(.largeTitle)
                .bold()

            if let weather = viewModel.weather {
                VStack(spacing: 10) {
                    Text("Temperature: \(weather.temp)°C")
                    Text("Feels Like: \(weather.feels_like)°C")
                    Text("Humidity: \(weather.humidity)%")
                    Text("Wind: \(weather.wind_speed) m/s")
                    Text("Cloud Cover: \(weather.cloud_pct)%")
                }
                .font(.title3)
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else {
                ProgressView("Loading Weather…")
            }
        }
        .padding()
        .onAppear {
            viewModel.loadWeather()
        }
    }
}

#Preview {
    ContentView()
}

