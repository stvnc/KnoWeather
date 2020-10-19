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
    
    func fetchWeatherValue(city: String, completion: @escaping(Result) -> Void, errorHandler: @escaping(Error) -> Void) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_Key)") else { return }
        
        print("URL: \(url)")
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("Error in weather: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherData)
                }
            }catch {
                print("Error in fetching news: \(error.localizedDescription)")
                return
            }
        }.resume()
    }
}
