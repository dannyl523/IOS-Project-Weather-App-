//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Student on 5/6/26.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var errorMessage: String?

    private let service = WeatherService()

    func loadWeather() {
        Task {
            do {
                self.weather = try await service.fetchWeather(
                    lat: "40.689047123831806",
                    lon: "-73.97678337976012"
                )
            } catch {
                self.errorMessage = "Failed to load weather"
            }
        }
    }
}
