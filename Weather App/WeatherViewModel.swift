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
    @Published var lastUpdated: Date?

    private let service = WeatherService()
    private var refreshTask: Task<Void, Never>?
    private var currentLat: String = "40.689047123831806"
    private var currentLon: String = "-73.97678337976012"

    func loadWeather(lat: String? = nil, lon: String? = nil) {
        if let lat = lat, let lon = lon {
            currentLat = lat
            currentLon = lon
        }

        Task {
            do {
                self.weather = try await service.fetchWeather(
                    lat: currentLat,
                    lon: currentLon
                )
                self.lastUpdated = Date()
                self.errorMessage = nil
            } catch {
                self.errorMessage = "Failed to load weather"
            }
        }
        scheduleAutoRefresh()
    }

    // Automatically re-fetches weather every 10 minutes
    private func scheduleAutoRefresh() {
        refreshTask?.cancel()
        refreshTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 600_000_000_000) // 10 minutes
                guard !Task.isCancelled else { break }
                do {
                    self.weather = try await service.fetchWeather(
                        lat: "40.689047123831806",
                        lon: "-73.97678337976012"
                    )
                    self.lastUpdated = Date()
                    self.errorMessage = nil
                } catch {
                    self.errorMessage = "Failed to load weather"
                }
            }
        }
    }

    deinit {
        refreshTask?.cancel()
    }
    
    
}
