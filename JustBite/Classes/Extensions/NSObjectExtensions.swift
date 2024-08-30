//
//  NSObjectExtensions.swift
//  Created by Sandeep Vishwakarma on 4/16/18.
//  Copyright © 2018 Sandeep. All rights reserved.
//


import Foundation

extension NSObject {
    
    class var className: String {
        
        return String(describing: self)
        
    }
}
