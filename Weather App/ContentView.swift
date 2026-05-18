//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Student on 5/1/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State private var showDetail = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Weather")
                .font(.largeTitle)
                .bold()

            if let weather = viewModel.weather {
                VStack(spacing: 10) {
                    Text("Temperature: \(String(format: "%.2f", weather.temp))°C")
                    Text("Feels Like: \(String(format: "%.2f", weather.feels_like))°C")
                    Text("Humidity: \(weather.humidity)%")
                    Text("Wind: \(String(format: "%.2f", weather.wind_speed)) m/s")
                    Text("Cloud Cover: \(weather.cloud_pct)%")
                }
                .font(.title3)
                
                Button("More Details"){
                    showDetail = true
                }
                .sheet(isPresented: $showDetail){
                    DetailView(weather: weather)
                }
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

