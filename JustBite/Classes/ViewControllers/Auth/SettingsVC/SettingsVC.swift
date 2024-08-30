//
//  SettingsVC.swift
//  JustBite
//
//  Created by Aman on 08/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import TPKeyboardAvoiding

class SettingsVC:BaseViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var tblSetting: TPKeyboardAvoidingTableView!
    
    let validation:Validation = Validation.validationManager() as! Validation
    internal var settingModel: LoginModeling?
    internal var dataStore = [DataStoreStruct]()
    
    var selectedSection = -1
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
        
        
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetup()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//         navigationSetup()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationSetup()
    }
    
    @objc func tapSectionBtn(sender:UIButton){
       if sender.tag == 0{
            if sender.tag == self.selectedSection {
                self.selectedSection = -1
            }else {
                self.selectedSection = sender.tag
            }
            self.tblSetting.reloadData()
        }else{
            
            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.WantToLogout, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    print("Cancel Button  Pressed", terminator: "")
                }
                else
                {
                  self.logoutApi()
                }
                
            }
            
            
           
        }
       
    }
    
    
    @objc func btnOldPasswordTapped(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 1)
        guard  let cell = tblSetting.cellForRow(at: indexPath) as? ChangePasswordCell else {
            print("No cell")
            return
        }
        
        cell.textFieldOldPasswordFloating?.isSecureTextEntry = cell.oldPasswordStatus ? true : false
        cell.imgPassword.image = cell.oldPasswordStatus ? #imageLiteral(resourceName: "close_eye") : #imageLiteral(resourceName: "open_eye")
        cell.oldPasswordStatus = !cell.oldPasswordStatus
        
    }
    
    @objc func btnNewPasswordTapped(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 1)
        guard  let cell = tblSetting.cellForRow(at: indexPath) as? ChangePasswordCell else {
            print("No cell")
            return
        }
        
        cell.textFieldNewPasswordFloating?.isSecureTextEntry = cell.newPasswordStatus ? true : false
        cell.imgNewPassword.image = cell.newPasswordStatus ? #imageLiteral(resourceName: "close_eye") : #imageLiteral(resourceName: "open_eye")
        cell.newPasswordStatus = !cell.newPasswordStatus
        
        
    }
    
    @objc func btnConfirmPasswordTapped(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 1)
        guard  let cell = tblSetting.cellForRow(at: indexPath) as? ChangePasswordCell else {
            print("No cell")
            return
        }
        cell.textFieldConfirmPasswordFloating?.isSecureTextEntry = cell.confirmPasswordStatus ? true : false
        cell.imgConfirmPassword.image = cell.confirmPasswordStatus ? #imageLiteral(resourceName: "close_eye") : #imageLiteral(resourceName: "open_eye")
        cell.confirmPasswordStatus = !cell.confirmPasswordStatus
    }
    
}


