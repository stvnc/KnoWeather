//
//  WeatherDetailsHeader.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class WeatherDetailsHeader: UIView {
    
    var weather: Weather?{
        didSet{
            configureData()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        layer.cornerRadius = frame.width / 4
    }
    
    func configureData(){
        
    }
}
