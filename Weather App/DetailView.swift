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

    var body: some View {
        VStack(spacing: 20) {
            Text("More Details")
                .font(.largeTitle)
                .bold()

            Text("Sunrise: \(unixToEST(weather.sunrise))")
            Text("Sunset: \(unixToEST(weather.sunset))")
        }
        .font(.title3)
        .padding()
    }
}
