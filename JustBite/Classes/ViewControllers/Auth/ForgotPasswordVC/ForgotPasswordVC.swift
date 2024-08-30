//
//  ForgotPasswordVC.swift
//  JustBite
//
//  Created by Aman on 06/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import MaterialComponents.MaterialTextFields


class ForgotPasswordVC: BaseViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tblForgotPassword: TPKeyboardAvoidingTableView!
    @IBOutlet weak var txtEmail: MDCTextField!
    
    
    
    
    
    //MARK: - Varibles for class
    let validation:Validation = Validation.validationManager() as! Validation
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var textFieldControllerFloatingEmail: MDCTextInputControllerUnderline?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    internal var forgetModel: LoginModeling?
    internal var dataStore = [DataStoreStruct]()
    
    
    //MARK: - View life cycle methods
    //TODO: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    
    //TODO: View Will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    //MARK: - Actions, Tap gestures
    //TODO: Submit Tapped
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        validationSetup()
       
    }
    
    
}
