//
//  HHelper.swift
//  JustBite
//
//  Created by Aman on 05/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import AVKit

let SCALE_FACTOR = HHelper.getScaleFactor()


class HHelper {
    
    class func getScaleFactor() -> CGFloat{
        
        let screenRect:CGRect = UIScreen.main.bounds
        let screenWidth:CGFloat = screenRect.size.width
        let scalefactor:CGFloat = screenWidth / 375.0
        return scalefactor
    }
    
    //MARK: - Validations
    
    //TODO: Validate email
    
    class func isValidEmail(_ email:String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    //TODO: Get IndexPath For tableView
    class func getIndexPathFor(view: UIView, tableView: UITableView) -> IndexPath? {
        let point = tableView.convert(view.bounds.origin, from: view)
        let indexPath = tableView.indexPathForRow(at: point)
        return indexPath
    }
}



