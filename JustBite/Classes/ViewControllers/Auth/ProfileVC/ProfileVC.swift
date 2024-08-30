//
//  ProfileVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import RealmSwift

class ProfileVC: BaseViewController {
    
    //MARK: - IBOutlets
   
    @IBOutlet weak var tblProfile: TPKeyboardAvoidingTableView!
    
    @IBOutlet weak var lblName: UILabel!
    
   
    
    
    
    //MARK: - Varibles for class
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    
    
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    
    internal var profileModel: ProfileModeling?
    internal var dataStore1 = [DataStoreStruct]()
    internal var dataStore2 = [DataStoreStruct]()
    internal var address_type = String()
    
    //MARK: - View life cycle methods
    //TODO: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
        navigationSetUpView()
    }
    
    //TODO: View Will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
        
         self.tabBarController?.tabBar.isHidden = false
        
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         self.tabBarController?.tabBar.isHidden = false
        navigationSetUpView()
        
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                if userInfo.id == ""{
                    self.lblName.text = ConstantTexts.WelcomeAppName
                    self.dataStore1.removeAll()
                    self.dataStore2.removeAll()
                    tblProfile.reloadData()
                    
                    _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                        if isOtherButton == true {
                            print("Cancel Button  Pressed", terminator: "")
                            let homeVC = AppStoryboard.tabbarClass as! TabBarViewC
                            homeVC.selectedIndex = 0

                            
                        }
                        else
                        {
                            super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                        }
                        
                    }
                }else{
                    
                }
            }else{
                self.lblName.text = ConstantTexts.WelcomeAppName
                self.dataStore1.removeAll()
                self.dataStore2.removeAll()
                tblProfile.reloadData()
                
                _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        print("Cancel Button  Pressed", terminator: "")
                        let homeVC = AppStoryboard.tabbarClass as! TabBarViewC
                        homeVC.selectedIndex = 0
                    }
                    else
                    {
                        super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                    }
                    
                }
                print("do nothing")
            }
            
        }
    
    
    
    @objc func tapSectionBtn(sender:UIButton){
        super.moveToNextViewC(name: "Auth", withIdentifier: EditProfileVC.className)
        
    }
}
