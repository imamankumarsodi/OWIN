//
//  cardView.swift
//  JustBite
//
//  Created by cst on 02/03/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import Foundation

import UIKit
@IBDesignable
class cardView: UIView {
    
    //@IBInspectable var cornerRadius: CGFloat = 8.0
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var SHAD: UIColor? = UIColor.black
    @IBInspectable var SHADO: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = 5.0
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0)
        
        layer.masksToBounds = false
        layer.shadowColor = SHAD?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = SHADO
        layer.shadowPath = shadowPath.cgPath
    }
}
