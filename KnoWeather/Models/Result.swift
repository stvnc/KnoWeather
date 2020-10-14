//
//  Result.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let coord: Coordinate
    let weather: Weather
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let timezone: Int
    let name: String
}

struct Coordinate: Codable {
    let lon: Float
    let lat: Float
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Int
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}



