//
//  WeatherService.swift
//  Weather App
//
//  Created by Student on 5/15/26.
//

import Foundation

class WeatherService {
    private let apiKey = "bETWdfP1Jv8ZDzvl7Z6v6hTD6KrYm3D8A8Zz8pff"

    func fetchWeather(lat: String, lon: String) async throws -> Weather {
        let urlString = "https://api.api-ninjas.com/v1/weather?lat=\(lat)&lon=\(lon)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Weather.self, from: data)
    }
}


