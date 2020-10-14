//
//  HomeViewController.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var result: Result?
    
    lazy var cloudContainer = CustomContainerView(image: #imageLiteral(resourceName: <#T##String#>), value: String(result?.clouds.all ?? 0))
    lazy var windContainer = CustomContainerView(image: #imageLiteral(resourceName: <#T##String#>), value: String(result?.wind.speed ?? 0))
    lazy var humidityContainer = CustomContainerView(image: #imageLiteral(resourceName: <#T##String#>), value: String(result?.main.humidity ?? 0))
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        Helpers.animateBackgroundColorBasedOnTime(view: view)
        
        let stack = UIStackView(arrangedSubviews: [cloudContainer, windContainer, humidityContainer])
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 16, paddingRight: 16)
    }
    
    
}
