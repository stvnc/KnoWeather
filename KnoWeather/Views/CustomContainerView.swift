//
//  CustomContainerView.swift
//  KnoWeather
//
//  Created by Vincent Angelo on 14/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class CustomContainerView: UIView {
    
    var imageView: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 35, width: 35)
        return iv
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    init(image: UIImage, value: String) {
        super.init(frame: .zero)
        self.imageView.image = image.withRenderingMode(.alwaysOriginal)
        self.valueLabel.text = value
        
        addSubview(imageView)
        imageView.centerY(inView: self)
        imageView.anchor(left: leftAnchor, paddingLeft: 5)
        
        addSubview(valueLabel)
        valueLabel.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, bottom: imageView.bottomAnchor, right: rightAnchor, paddingLeft: 5, paddingRight: 5)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
