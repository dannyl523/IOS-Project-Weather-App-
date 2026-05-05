//
//  ContentView.swift
//  Weather App
//
//  Created by Student on 5/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = "New York"
    @State private var temperature: String = "--"
    @State private var description: String = "--"
    @State private var humidity: String = "--"

    let apiKey = "YOUR_API_KEY_HERE"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter city", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Get Weather") {
                fetchWeather()
            }

            Text("City: \(city)")
                .font(.title)

            Text("Temperature: \(temperature)°C")
            Text("Condition: \(description)")
            Text("Humidity: \(humidity)%")
        }
        .padding()
    }

    func fetchWeather() {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else { return }

    }
}
