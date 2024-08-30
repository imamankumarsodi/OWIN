//
//  ChangePasswordCell.swift
//  JustBite
//
//  Created by Aman on 04/07/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class ChangePasswordCell: SBaseTableViewCell {
    @IBOutlet weak var imgPassword: UIImageView!
    
    @IBOutlet weak var imgNewPassword: UIImageView!
    
    @IBOutlet weak var imgConfirmPassword: UIImageView!
    
     @IBOutlet weak var textFieldOldPasswordFloating = MDCTextField()
    var textFieldControllerFloatingPassword: MDCTextInputControllerUnderline?
    
    
    @IBOutlet weak var textFieldNewPasswordFloating = MDCTextField()
    var textFieldControllerFloatingNewPassword: MDCTextInputControllerUnderline?
    
    @IBOutlet weak var textFieldConfirmPasswordFloating = MDCTextField()
    var textFieldControllerFloatingConfirmPassword: MDCTextInputControllerUnderline?
    
    
    @IBOutlet weak var btnOldPasswordRef: UIButton!
    
    @IBOutlet weak var btnNewPasswordRef: UIButton!
    
    @IBOutlet weak var btnConfirmPasswordRef: UIButton!
    
    var oldPasswordStatus = Bool()
    var newPasswordStatus = Bool()
    var confirmPasswordStatus = Bool()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        textFieldOldPasswordFloating?.autocapitalizationType = .words
//        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
//        textFieldControllerFloatingPassword = MDCTextInputControllerUnderline(textInput: textFieldOldPasswordFloating)
//        textFieldControllerFloatingPassword?.floatingPlaceholderScale = 1.10
//
//        textFieldOldPasswordFloating?.textColor = AppColor.textColor
//        textFieldControllerFloatingPassword?.activeColor = AppColor.placeHolderColor
//        textFieldControllerFloatingPassword?.normalColor = AppColor.placeHolderColor
//        textFieldOldPasswordFloating?.placeholderLabel.textColor = AppColor.themeColor
//        textFieldControllerFloatingPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
//        textFieldControllerFloatingPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
//        textFieldControllerFloatingPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
//        textFieldOldPasswordFloating?.placeholder = ConstantTexts.passwordPlaceHolder
        textFieldOldPasswordFloating?.underline?.isHidden = false
        textFieldOldPasswordFloating?.clearButton.isHidden = true
//        textFieldOldPasswordFloating?.keyboardType = .default
//
//
//        textFieldNewPasswordFloating?.autocapitalizationType = .words
//        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
//        textFieldControllerFloatingNewPassword = MDCTextInputControllerUnderline(textInput: textFieldNewPasswordFloating)
//        textFieldControllerFloatingNewPassword?.floatingPlaceholderScale = 1.10
//
//        textFieldNewPasswordFloating?.textColor = AppColor.textColor
//        textFieldControllerFloatingNewPassword?.activeColor = AppColor.placeHolderColor
//        textFieldControllerFloatingNewPassword?.normalColor = AppColor.placeHolderColor
//        textFieldNewPasswordFloating?.placeholderLabel.textColor = AppColor.themeColor
//        textFieldControllerFloatingNewPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
//        textFieldControllerFloatingNewPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
//        textFieldControllerFloatingNewPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
//        textFieldNewPasswordFloating?.placeholder = ConstantTexts.passwordPlaceHolder
        textFieldNewPasswordFloating?.underline?.isHidden = false
        textFieldNewPasswordFloating?.clearButton.isHidden = true
//        textFieldNewPasswordFloating?.keyboardType = .default
//
//
//
//        textFieldConfirmPasswordFloating?.autocapitalizationType = .words
//        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
//        textFieldControllerFloatingConfirmPassword = MDCTextInputControllerUnderline(textInput: textFieldConfirmPasswordFloating)
//        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderScale = 1.10
//
//        textFieldConfirmPasswordFloating?.textColor = AppColor.textColor
//        textFieldControllerFloatingConfirmPassword?.activeColor = AppColor.placeHolderColor
//        textFieldControllerFloatingConfirmPassword?.normalColor = AppColor.placeHolderColor
//        textFieldConfirmPasswordFloating?.placeholderLabel.textColor = AppColor.themeColor
//        textFieldControllerFloatingConfirmPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
//        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
//        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
//        textFieldConfirmPasswordFloating?.placeholder = ConstantTexts.passwordPlaceHolder
        textFieldConfirmPasswordFloating?.underline?.isHidden = false
        textFieldConfirmPasswordFloating?.clearButton.isHidden = true
//        textFieldConfirmPasswordFloating?.keyboardType = .default
//
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        textFieldOldPasswordFloating?.autocapitalizationType = .words
//        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
//        textFieldControllerFloatingPassword = MDCTextInputControllerUnderline(textInput: textFieldOldPasswordFloating)
//        textFieldControllerFloatingPassword?.floatingPlaceholderScale = 1.10
//
//        textFieldOldPasswordFloating?.textColor = AppColor.textColor
//        textFieldControllerFloatingPassword?.activeColor = AppColor.placeHolderColor
//        textFieldControllerFloatingPassword?.normalColor = AppColor.placeHolderColor
//        textFieldOldPasswordFloating?.placeholderLabel.textColor = AppColor.themeColor
//        textFieldControllerFloatingPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
//        textFieldControllerFloatingPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
//        textFieldControllerFloatingPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
//        textFieldOldPasswordFloating?.placeholder = ConstantTexts.passwordPlaceHolder
        textFieldOldPasswordFloating?.underline?.isHidden = false
        textFieldOldPasswordFloating?.clearButton.isHidden = true
//        textFieldOldPasswordFloating?.keyboardType = .default
//
//
//        textFieldNewPasswordFloating?.autocapitalizationType = .words
//        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
//        textFieldControllerFloatingNewPassword = MDCTextInputControllerUnderline(textInput: textFieldNewPasswordFloating)
//        textFieldControllerFloatingNewPassword?.floatingPlaceholderScale = 1.10
//
//        textFieldNewPasswordFloating?.textColor = AppColor.textColor
//        textFieldControllerFloatingNewPassword?.activeColor = AppColor.placeHolderColor
//        textFieldControllerFloatingNewPassword?.normalColor = AppColor.placeHolderColor
//        textFieldNewPasswordFloating?.placeholderLabel.textColor = AppColor.themeColor
//        textFieldControllerFloatingNewPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
//        textFieldControllerFloatingNewPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
//        textFieldControllerFloatingNewPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
//        textFieldNewPasswordFloating?.placeholder = ConstantTexts.passwordPlaceHolder
        textFieldNewPasswordFloating?.underline?.isHidden = false
        textFieldNewPasswordFloating?.clearButton.isHidden = true
//        textFieldNewPasswordFloating?.keyboardType = .default
//
//
//
//        textFieldConfirmPasswordFloating?.autocapitalizationType = .words
//        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
//        textFieldControllerFloatingConfirmPassword = MDCTextInputControllerUnderline(textInput: textFieldConfirmPasswordFloating)
//        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderScale = 1.10
//
//        textFieldConfirmPasswordFloating?.textColor = AppColor.textColor
//        textFieldControllerFloatingConfirmPassword?.activeColor = AppColor.placeHolderColor
//        textFieldControllerFloatingConfirmPassword?.normalColor = AppColor.placeHolderColor
//        textFieldConfirmPasswordFloating?.placeholderLabel.textColor = AppColor.themeColor
//        textFieldControllerFloatingConfirmPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
//        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
//        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
//        textFieldConfirmPasswordFloating?.placeholder = ConstantTexts.passwordPlaceHolder
        textFieldConfirmPasswordFloating?.underline?.isHidden = false
        textFieldConfirmPasswordFloating?.clearButton.isHidden = true
//        textFieldConfirmPasswordFloating?.keyboardType = .default

        // Configure the view for the selected state
    }
    
}
