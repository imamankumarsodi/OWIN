//
//  JustBiteCreditVC.swift
//  JustBite
//
//  Created by Aman on 19/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class JustBiteCreditVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    
   @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnLoginRef: UIButton!
    @IBOutlet weak var btnViewAllRef: UIButton!
    @IBOutlet weak var btnHeaderRef: UIButton!
    //MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
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
    
    @IBAction func btnStatementTapped(_ sender: UIButton) {
        super.moveToNextViewC(name: "Remaining", withIdentifier: CreditStatementVC.className)
        
        
    }
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        super.moveToNextViewC(name: "Remaining", withIdentifier: TopUpOffersVC.className)
        
        
    }
    
    
}
