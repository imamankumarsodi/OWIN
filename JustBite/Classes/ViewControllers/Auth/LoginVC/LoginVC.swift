//
//  LoginVC.swift
//  JustBite
//
//  Created by Aman on 04/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import MaterialComponents.MaterialTextFields
import RealmSwift
import GoogleSignIn

class LoginVC: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgPassword: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var tblViewLogin: TPKeyboardAvoidingTableView!
    @IBOutlet weak var lblFooter: UILabel!
    @IBOutlet weak var btnLoginRef: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var txtEmail: MDCTextField!
    @IBOutlet weak var txtPassword: MDCTextField!
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var textFieldControllerFloatingPassword: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingEmail: MDCTextInputControllerUnderline?
    var showPasswordStatus = Bool()
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    //MARK: - Varibles for class
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    internal var loginModel: LoginModeling?
    internal var dataStore = [DataStoreStruct]()
    
    
    //MARK: - View life cycle methods
    //TODO: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  GIDSignIn.sharedInstance().uiDelegate = self

        initialSetup()
    }


    //TODO: View will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUP()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    //MARK: - Actions, Tap gestures
    //TODO: Login Tapped
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
       print("app delegate m root bana kar tab bar bhej dena")
        validationSetup()
        
      //  moveToHomeVC()
    }
    
    //TODO: Forgot password Tapped
    
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
    super.moveToNextViewC(name: "Auth", withIdentifier: ForgotPasswordVC.className)
        
        
    }
    
    @IBAction func fbLogIn(_ sender: Any) {
        FBLoginSetUP()
    
    }
    
    @IBAction func btnShowPasswordTapped(_ sender: UIButton) {
        txtPassword.isSecureTextEntry = showPasswordStatus ? true : false
        imgPassword.image = showPasswordStatus ? #imageLiteral(resourceName: "close_eye") : #imageLiteral(resourceName: "open_eye")
        showPasswordStatus = !showPasswordStatus
    }
    
    @IBAction func btnSkipTapped(_ sender: UIButton) {
        moveToHomeVC()
        
    }
    
    @IBAction func btnGoogleTapped(_ sender: UIButton) {
        if InternetConnection.internetshared.isConnectedToNetwork(){
            self.macroObj.showLoader(view: self.view)

            
            GIDSignIn.sharedInstance()?.signOut()
            GIDSignIn.sharedInstance()?.delegate = self
            GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance()?.signIn()
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        super.moveToNextViewC(name: "Auth", withIdentifier: SignupVC.className)
    }
    
}
