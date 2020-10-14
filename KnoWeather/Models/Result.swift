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
