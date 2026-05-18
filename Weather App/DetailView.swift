//
//  DetailView.swift
//  Weather App
//
//  Created by Danny Li on 5/17/26.
//

import SwiftUI

struct DetailView: View {
    let weather: Weather

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
        VStack(spacing: 20) {
            Text("More Details")
                .font(.largeTitle)
                .bold()

            Divider()

            // Wind section
            VStack(spacing: 8) {
                Label("Wind", systemImage: "wind")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("Direction: \(weather.wind_degrees)° (\(compassDirection(weather.wind_degrees)))")
                Text("Speed: \(String(format: "%.2f", weather.wind_speed)) m/s")
            }

            Divider()

            // Sun section
            VStack(spacing: 8) {
                Label("Sun", systemImage: "sun.horizon.fill")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("Sunrise: \(unixToEST(weather.sunrise))")
                Text("Sunset: \(unixToEST(weather.sunset))")
                Text("Daylight: \(daylightDuration)")
                    .foregroundColor(.secondary)
            }

            Divider()

            // Temperature range section
            VStack(spacing: 8) {
                Label("Today's Range", systemImage: "thermometer.medium")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("High: \(String(format: "%.1f", weather.max_temp))°C")
                Text("Low: \(String(format: "%.1f", weather.min_temp))°C")
            }

            Divider()

            // Humidity section
            VStack(spacing: 8) {
                Label("Humidity", systemImage: "humidity.fill")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("\(weather.humidity)% — \(humidityDescription)")
            }
        }
        .font(.title3)
        .padding()
    }
}
