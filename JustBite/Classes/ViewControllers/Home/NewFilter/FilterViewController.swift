//
//  FilterViewController.swift
//  JustBite
//
//  Created by cst on 31/01/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {

    @IBOutlet weak var filterTV: UITableView!
    
    var tasteArray = ["Sweet","Salted","Mixed"]
    var typeArray = ["Vegetarian","Non-Vegetarian"]
    var eatArray = ["Lunch","Braekfast","Dinner"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationSetUpView()
    }
}
