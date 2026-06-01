//
//  ContentView.swift
//  Weather App
//
//  Created by Student on 5/1/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State private var showDetail = false
    @State private var logoScale: CGFloat = 1.0
    @State private var textPressed = false
    @State private var iconPressed = false
    @AppStorage("useFahrenheit") private var useFahrenheit: Bool = false

    // Returns a SF Symbol name based on cloud cover percentage
    func weatherIcon(cloudPct: Int) -> String {
        switch cloudPct {
        case 0..<20:  return "sun.max.fill"
        case 20..<50: return "cloud.sun.fill"
        case 50..<80: return "cloud.fill"
        default:      return "cloud.heavyrain.fill"
        }
    }

    // Returns the icon's color based on cloud cover
    func weatherIconColor(cloudPct: Int) -> Color {
        switch cloudPct {
        case 0..<20:  return .yellow
        case 20..<50: return .yellow
        case 50..<80: return .gray
        default:      return .blue
        }
    }

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
            
            HStack(spacing: 12) {
                Text("Units:")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Picker("Units", selection: $useFahrenheit) {
                    Text("Celsius").tag(false)
                    Text("Fahrenheit").tag(true)
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)

            if let weather = viewModel.weather {
                Image(systemName: weatherIcon(cloudPct: weather.cloud_pct))
                // Icon changes dynamically based on cloud cover —
                // sunny, partly cloudy, overcast, or rainy.
                    .font(.system(size: 60))
                    .foregroundColor(weatherIconColor(cloudPct: weather.cloud_pct))
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
                    // Daily range — new addition
                    Text("High / Low: \(String(format: "%.1f", weather.max_temp))° / \(String(format: "%.1f", weather.min_temp))°C")
                        .foregroundColor(.secondary)

                    Text("Temperature: \(formatTemp(weather.temp))°\(useFahrenheit ? "F" : "C")")
                    Text("Feels Like: \(formatTemp(weather.feels_like))°\(useFahrenheit ? "F" : "C")")
                    Text("Humidity: \(weather.humidity)%")
                    Text("Wind: \(String(format: "%.2f", weather.wind_speed)) m/s")
                    Text("Cloud Cover: \(weather.cloud_pct)%")
                }
                .font(.title3)

                // Last updated timestamp
                if let updated = viewModel.lastUpdated {
                    Text("Updated \(updated, style: .relative) ago")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Button("More Details") {
                    showDetail = true
                }
                .sheet(isPresented: $showDetail) {
                    NavigationStack {
                        DetailView(weather: weather)
                            .navigationTitle("Weather Details")
                            .navigationBarTitleDisplayMode(.inline)
                            .padding()
                    }
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(20)
                }

            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                Button("Retry") {
                    viewModel.loadWeather()
                }
                .buttonStyle(.bordered)
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
