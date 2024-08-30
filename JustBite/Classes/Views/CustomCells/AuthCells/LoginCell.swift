//
//  LoginCell.swift
//  JustBite
//
//  Created by Aman on 05/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class LoginCell: SBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var textFieldFloating = MDCTextField()
    
    //MARK:- All Propetise
    
    var textFieldControllerFloating: MDCTextInputControllerUnderline?

    
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpTextField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    
    
    
    // MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configureCellWith(info: DataStoreStruct) {
        self.textFieldFloating?.placeholder = info.placeholder
        self.textFieldFloating?.text = info.value
        
        if info.type == .Name {
            textFieldFloating?.autocapitalizationType = .words
        }
        if info.type == .Email {
            textFieldFloating?.keyboardType = .emailAddress
            imgViewIcon.image = #imageLiteral(resourceName: "mail_icon")
        }
        if info.type == .MobileNumber {
            textFieldFloating?.keyboardType = .numberPad
            imgViewIcon.image = #imageLiteral(resourceName: "call_icon")
        }
        if info.type == .Password {
            textFieldFloating?.isSecureTextEntry = true
            textFieldFloating?.keyboardType = .default
            imgViewIcon.image = #imageLiteral(resourceName: "keyicontwo")
        }
        if info.type == .NewPassword{
            textFieldFloating?.isSecureTextEntry = true
            textFieldFloating?.keyboardType = .default
        }
        if info.type == .ConfirmNewPassword {
            textFieldFloating?.isSecureTextEntry = true
            textFieldFloating?.keyboardType = .default
        }
        if info.type == .OldPassword {
            textFieldFloating?.isSecureTextEntry = true
            textFieldFloating?.keyboardType = .default
        }
        
        if info.type == .NameOnCard {
            textFieldFloating?.keyboardType = .default
        }
        if info.type == .CardNumber {
            textFieldFloating?.keyboardType = .numberPad
        }
        if info.type == .User{
            textFieldFloating?.keyboardType = .emailAddress
            imgViewIcon.image = #imageLiteral(resourceName: "user_icon_new")
        }
        
        if info.type == .Landmark{
            textFieldFloating?.keyboardType = .default
            imgViewIcon.image = #imageLiteral(resourceName: "map_location")
        }
        if info.type == .PinCode{
            textFieldFloating?.keyboardType = .numberPad
            imgViewIcon.image = #imageLiteral(resourceName: "map_location")
        }
        
    }
    
    
    //TODO: - Text Field
    
    private func setUpTextField(){
        
        textFieldFloating?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFieldFloating)
        textFieldControllerFloating?.floatingPlaceholderScale = 1.10
        
        textFieldFloating?.textColor = AppColor.textColor
        textFieldControllerFloating?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloating?.normalColor = AppColor.placeHolderColor
        textFieldFloating?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloating?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloating?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloating?.floatingPlaceholderActiveColor = AppColor.themeColor

        textFieldFloating?.underline?.isHidden = false
        textFieldFloating?.clearButton.isHidden = false
        
        
        
        
    }
    
}
