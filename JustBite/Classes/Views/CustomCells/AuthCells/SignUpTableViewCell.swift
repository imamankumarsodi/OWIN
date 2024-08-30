//
//  SignUpTableViewCell.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class SignUpTableViewCell: SBaseTableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtLastName: MDCTextField!
    @IBOutlet weak var txtFirstName: MDCTextField!
    //MARK:- All Propetise
    
    var textFieldControllerFloating: MDCTextInputControllerUnderline?
    var textFieldControllerFloating1: MDCTextInputControllerUnderline?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()        // Initialization code
        setUpTextFirstNameField()
        setUpTextLastNameField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    private func setUpTextFirstNameField(){
        txtFirstName?.autocapitalizationType = .words
        txtFirstName.placeholder = ConstantTexts.nameFirst
        txtFirstName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: txtFirstName)
        textFieldControllerFloating?.floatingPlaceholderScale = 1.10
        
        txtFirstName?.textColor = AppColor.textColor
        textFieldControllerFloating?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloating?.normalColor = AppColor.placeHolderColor
        txtFirstName?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloating?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloating?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloating?.floatingPlaceholderActiveColor = AppColor.themeColor
        
        txtFirstName?.underline?.isHidden = false
        txtFirstName?.clearButton.isHidden = false
        
        
        
        
    }
    
    private func setUpTextLastNameField(){
        txtLastName?.autocapitalizationType = .words
        txtLastName.placeholder = ConstantTexts.nameLast
        txtLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloating1 = MDCTextInputControllerUnderline(textInput: txtLastName)
        textFieldControllerFloating1?.floatingPlaceholderScale = 1.10
        
        txtLastName?.textColor = AppColor.textColor
        textFieldControllerFloating1?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloating1?.normalColor = AppColor.placeHolderColor
        txtLastName?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloating1?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloating1?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloating1?.floatingPlaceholderActiveColor = AppColor.themeColor
        
        txtLastName?.underline?.isHidden = false
        txtLastName?.clearButton.isHidden = false
        
        
        
        
    }
    
    
}
