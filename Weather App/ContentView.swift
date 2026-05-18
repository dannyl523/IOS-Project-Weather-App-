//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Student on 5/1/26.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State private var showDetail = false
    @State private var logoScale: CGFloat = 1.0
    @State private var textPressed = false
    @State private var iconPressed = false
    @State private var useFahrenheit = false

    var body: some View {
        VStack(spacing: 20) {
            Text("What is the weather at Tech?")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(textPressed ? .blue : .black)
                .onLongPressGesture {
                    textPressed.toggle()
                }

            if let weather = viewModel.weather {
                Image(systemName: "cloud.sun.fill")
                // Future implementation might include changing the image associated with the projet, so that on raining / non sunny days, the image changes.
                    .font(.system(size: 60))
                    .foregroundColor(iconPressed ? .orange : .yellow)
                    .scaleEffect(logoScale)
                    .animation(.spring(response: 0.4, dampingFraction: 0.5), value: logoScale)
                    .onTapGesture {
                        logoScale = logoScale == 1.0 ? 1.5 : 1.0
                    }
                    .onLongPressGesture {
                        iconPressed.toggle()
                    }

                // °C / °F toggle
                Toggle(useFahrenheit ? "Fahrenheit" : "Celsius", isOn: $useFahrenheit)
                    .toggleStyle(.button)
                    .buttonStyle(.bordered)
                    .tint(.blue)

                VStack(spacing: 10) {
                    Text("Temperature: \(formatTemp(weather.temp))°\(useFahrenheit ? "F" : "C")")
                    Text("Feels Like: \(formatTemp(weather.feels_like))°\(useFahrenheit ? "F" : "C")")
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

    // MARK: - Helpers
    private func formatTemp(_ celsius: Double) -> String {
        let value = useFahrenheit ? (celsius * 9 / 5) + 32 : celsius
        return String(format: "%.2f", value)
    }
}

#Preview {
    ContentView()
}
