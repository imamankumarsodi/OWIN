//
//  AppStoryboard.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

struct AppStoryboard {
    
    public static let tabbarClass = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewC")
    public static let auth = UIStoryboard(name: "Auth", bundle: nil)
    public static let home = UIStoryboard(name: "Home", bundle: nil)
    public static let pops = UIStoryboard(name: "PopUps", bundle: nil)
    public static let remain = UIStoryboard(name: "Remaining", bundle: nil)
//    public static let setting = UIStoryboard(name: "Setting", bundle: nil)
    
    
}
