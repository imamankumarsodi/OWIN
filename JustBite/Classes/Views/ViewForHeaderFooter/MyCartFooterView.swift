//
//  MyCartFooterView.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import GoogleMaps

class MyCartFooterView: UIView {


    var textFieldControllerFloating: MDCTextInputControllerUnderline?
    @IBOutlet weak var lblTotalPriceHeading: UILabel!
    @IBOutlet weak var lblDiscountHeading: UILabel!
    @IBOutlet weak var lblPaidAmount: UILabel!
    @IBOutlet weak var lblTotalAmountValue: UILabel!
    @IBOutlet weak var lblPaidValue: UILabel!
    @IBOutlet weak var lblDiscountValue: UILabel!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var viewText: UIView!
    @IBOutlet weak var textFieldFloating = MDCTextField()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnEditRef: UIButton!
    
    @IBOutlet weak var btnAddressRef: UIButton!
    
   
}



// MARK: - Text Field Delegates

extension MyCartFooterView: UITextFieldDelegate {

   
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textFieldFloating!.text!.count > 50 && string != "" {
                return false
            }
        
        return true
    }
    
}
