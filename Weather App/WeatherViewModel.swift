//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Student on 5/6/26.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherText = "Loading..."

    func fetchWeather(for lat: String, for lon: String) {
        let urlString = "https://api.api-ninjas.com/v1/weather?lat=\(lat)&lon=\(lon)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("bETWdfP1Jv8ZDzvl7Z6v6hTD6KrYm3D8A8Zz8pff", forHTTPHeaderField: "X-Api-Key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {

                DispatchQueue.main.async {
                    self.weatherText = "\(json)"
                }
            }
        }.resume()
    }
}
