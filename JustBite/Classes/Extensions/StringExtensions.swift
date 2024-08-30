//
//  StringExtensions.swift
//  Created by Sandeep Vishwakarma on 4/16/18.
//  Copyright © 2018 Sandeep. All rights reserved.
//

import UIKit

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
}

extension UIView {
    func dropGreenShadow(scale: Bool = true) {
        layer.shadowColor = AppColor.placeHolderColor.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
    
    func dropGrayShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
}

extension Date {
    init(dateString:String) {
        self = Date.iso8601Formatter.date(from: dateString)!
    }
    
    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withTime,.withFullDate,.withDashSeparatorInDate,.withColonSeparatorInTime]
        return formatter
    }()
}
