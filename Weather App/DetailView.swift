//
//  DetailView.swift
//  Weather App
//
//  Created by Danny Li on 5/17/26.
//

import SwiftUI

struct DetailView: View {
    let weather: Weather
    @AppStorage("useFahrenheit") private var useFahrenheit: Bool = false

    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        return formatter
    }

    func unixToEST(_ unix: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unix))
        return timeFormatter.string(from: date)
    }

    // Converts wind degrees to a readable compass direction
    func compassDirection(_ degrees: Int) -> String {
        let directions = ["N", "NNE", "NE", "ENE",
                          "E", "ESE", "SE", "SSE",
                          "S", "SSW", "SW", "WSW",
                          "W", "WNW", "NW", "NNW"]
        let index = Int((Double(degrees) / 22.5) + 0.5) % 16
        return directions[index]
    }

    // Computes total daylight hours and minutes from sunrise/sunset unix timestamps
    var daylightDuration: String {
        let seconds = weather.sunset - weather.sunrise
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return "\(hours)h \(minutes)m"
    }

    // Humidity comfort description
    var humidityDescription: String {
        switch weather.humidity {
        case 0..<30:  return "Dry"
        case 30..<60: return "Comfortable"
        case 60..<80: return "Humid"
        default:      return "Very Humid"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Temperature section
                HStack(spacing: 12) {
                    Image(systemName: "thermometer.sun")
                        .foregroundStyle(.orange)
                    let feels = useFahrenheit ? (weather.feels_like * 9/5 + 32) : weather.feels_like
                    Text("Feels Like: \(String(format: "%.1f", feels))\(useFahrenheit ? "°F" : "°C")")
                }

                // Wind section
                HStack(spacing: 12) {
                    Image(systemName: "wind")
                        .foregroundStyle(.teal)
                    Text("Wind: \(String(format: "%.1f", weather.wind_speed)) m/s • \(weather.wind_degrees)°")
                }

                // Humidity
                HStack(spacing: 12) {
                    Image(systemName: "humidity")
                        .foregroundStyle(.blue)
                    Text("Humidity: \(weather.humidity)%")
                }

                // Cloud cover
                HStack(spacing: 12) {
                    Image(systemName: "cloud.fill")
                        .foregroundStyle(.gray)
                    Text("Cloud Cover: \(weather.cloud_pct)%")
                }

                Divider().padding(.vertical, 4)

                // Sun times
                HStack(spacing: 12) {
                    Image(systemName: "sunrise.fill")
                        .foregroundStyle(.yellow)
                    Text("Sunrise: \(unixToEST(weather.sunrise))")
                }

                HStack(spacing: 12) {
                    Image(systemName: "sunset.fill")
                        .foregroundStyle(.orange)
                    Text("Sunset: \(unixToEST(weather.sunset))")
                }
            }
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
        }
    }
}
