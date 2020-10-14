//
//  Helpers.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

struct Helpers {
    static func animateBackgroundColorBasedOnTime(view: UIView){
        let hour = NSCalendar.current.component(.hour, from: NSDate() as Date)
        
        switch hour {
        case 1...6: view.backgroundColor = .darkGray
            break
        case 7...18: view.backgroundColor = .lightGray
            break
        case 19...24: view.backgroundColor = .darkGray
            break
        default: view.backgroundColor = .lightGray
        }
    }
}
