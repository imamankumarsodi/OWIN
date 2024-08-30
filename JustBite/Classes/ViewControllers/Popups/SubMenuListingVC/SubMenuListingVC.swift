//
//  SubMenuListingVC.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

protocol backToRestDetials {
    func sendDataBack(index:Int,price:Double,addon:String,isNewOrder:String,userType:String,catIndex:Int)
}

protocol backToCart {
    func sendDataBack(index:Int,price:Double,addon:String,isNewOrder:String)
}


class SubMenuListingVC:  BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblAddOns: UITableView!
    @IBOutlet weak var btnTotal: UILabel!
    @IBOutlet weak var viewFooter: UIView!
    
    //MARK: - Variables
    internal var previousOffset: CGFloat = 0
    var customizeDataModelArray = [CustomizesDataModel]()
    var price = Int()
    var quantity = Int()
    var index = Int()
    var totalPrice = Int()
    var backObj:backToRestDetials?
    var backObjC:backToCart?
    var addOnString = String()
    var addOnArray = [String]()
    var isNewOrder = String()
    var isComing = String()
    var userType = String()
    var catIndex = Int()
    
    //MARK: - View Life Cycle Methods
    //TODO: View didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initialStup()
        // Do any additional setup after loading the view.
    }
    
    //TODO: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        super.hideStatusBar(true)
    }
    
    //MARK: - Actions,Gesture
    //TODO: Save Actions
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        
        saveTapped(index:sender.tag)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
