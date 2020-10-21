//
//  WeatherDetailsHeader.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherDetailsHeader: UIView {
    
    var result: Result?{
        didSet{
            print("result")
            configureData()
        }
    }
    
    let cityLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.text = "Jakarta"
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.text = "32"
        return label
    }()
    
    let weatherDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.text = "Cloudy"
        return label
    }()
    
    let heavyTemp: UILabel = {
       let label = UILabel()
        label.text = "H: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    let lowTemp: UILabel = {
       let label = UILabel()
        label.text = "L: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
//    let degreesLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 42)
//        label.textColor = .white
//        label.text = "°"
//        return label
//    }()
    
    let weatherIcon: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "Logo").withRenderingMode(.alwaysOriginal)
        iv.setDimensions(height: 240, width: 240)
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        
        let hStack = UIStackView(arrangedSubviews: [heavyTemp, lowTemp])
        hStack.axis = .horizontal
        hStack.spacing = 10
        
        let stack = UIStackView(arrangedSubviews: [cityLabel, weatherDetails, temperatureLabel, hStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 5
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: topAnchor, paddingTop: 5)
        
        addSubview(weatherIcon)
        weatherIcon.anchor(top: stack.bottomAnchor, paddingTop: 10)
        weatherIcon.centerX(inView: self)
    }
    
    func configureData(){
        guard let result = result else { return }
        cityLabel.text = result.name
        temperatureLabel.text = String(result.main.temp)
        weatherDetails.text = result.weather[0].main
        heavyTemp.text! += String(result.main.temp_max)
        lowTemp.text! += String(result.main.temp_min)
        weatherIcon.sd_setImage(with: URL(string: "http://openweathermap.org/img/wn/\(result.weather[0].icon)@2x.png"), completed: nil)
        
        print("icon url: \(result.weather[0].icon)")
    }
}
