//
//  NetworkLayer.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct NetworkLayer {
    
    
    static var shared = NetworkLayer()

    private init() {}
    
    let session = URLSession.shared
    
    func fetchWeatherValue(country: String, completion: @escaping(Result) -> Void) {
        
    }
}
