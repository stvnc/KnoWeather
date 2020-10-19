//
//  HomeViewController.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var result: Result?{
        didSet{
            configureDatas()
        }
    }
    var location: CLLocation?
    var locationManager:CLLocationManager!
    
    var timer: Timer?
    
    let geocoder = CLGeocoder() //object that will perform geocoding
    var placemark: CLPlacemark?{
        didSet{
            fetchCityDatas()
        }
    } // object that contains the address result
    var performingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    var updatingLocation = false
    var lastLocationError: Error?
    
    lazy var cloudContainer = CustomContainerView(image: #imageLiteral(resourceName: "Logo"), value: String(result?.clouds.all ?? 0))
    lazy var windContainer = CustomContainerView(image: #imageLiteral(resourceName: "Logo"), value: String(result?.wind.speed ?? 0))
    lazy var humidityContainer = CustomContainerView(image: #imageLiteral(resourceName: "Logo"), value: String(result?.main.humidity ?? 0))
    
    lazy var detailsHeader = WeatherDetailsHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthorization()
        configureView()
    }
    
    func configureView() {
        Helpers.animateBackgroundColorBasedOnTime(view: view)
        
        let stack = UIStackView(arrangedSubviews: [cloudContainer, windContainer, humidityContainer])
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(detailsHeader)
        detailsHeader.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 16, paddingRight: 16)
    }
    
    func checkAuthorization(){
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        determineCurrentLocation()
    }
    
    func showLocationServicesDeniedAlert(){
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func stopLocationManager(){
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
            
            if let timer = timer {
                timer.invalidate()
            }
        }
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func fetchCityDatas(){
        if let cityName = placemark?.locality {
            print("city name: \(cityName)")
            
            NetworkLayer.shared.fetchWeatherValue(city: cityName, completion: { result in
                self.result = result
            }) { error in
                print(error.localizedDescription)
            }
        }
        
    }
    
    func configureDatas(){
        detailsHeader.result = result
        cloudContainer.valueLabel.text = String(result?.clouds.all ?? 0)
        windContainer.valueLabel.text = String(result?.wind.speed ?? 0)
        humidityContainer.valueLabel.text = String(result?.main.humidity ?? 0)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let newLocation = locations.last!
            
            if newLocation.timestamp.timeIntervalSinceNow < -5 {
                return
            }
            
            if newLocation.horizontalAccuracy < 0 {
                return
            }
            
            var distance = CLLocationDistance(Double.greatestFiniteMagnitude)
            if let location = location {
                distance = newLocation.distance(from: location)
            }
            
            if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
                lastLocationError = nil
                location = newLocation
                
                if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                    print("We're done!")
                    stopLocationManager()
                    
                    if distance > 0 {
                        performingReverseGeocoding = false
                    }
                }
                
                if !performingReverseGeocoding {
                    print("... Going to geocode")
                    
                    performingReverseGeocoding = true
                    geocoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
                        self.lastGeocodingError = error
                        
                        if error == nil, let p = placemarks, !p.isEmpty {
                            self.placemark = p.last!
                        } else {
                            self.placemark = nil
                        }
                        
                        self.performingReverseGeocoding = false                    }
                } else if distance < 1 {
                    let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
                    if timeInterval > 10 {
                        print("Force Done!")
                        stopLocationManager()
                    }
                }
            }

        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error - locationManager: \(error.localizedDescription)")
        }
}

