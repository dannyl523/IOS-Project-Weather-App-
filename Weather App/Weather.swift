//
//  Weather.swift
//  Weather App
//
//  Created by Student on 5/15/26.
//

import Foundation

struct Weather: Codable{
    let temp: Double
    let feels_like: Double
    let humidity: Int
    let wind_speed: Double
    let wind_degrees: Int
    let sunrise: Int
    let sunset: Int
    let cloud_pct: Int
}
