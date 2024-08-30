//
//  ShareReviewVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import Cosmos

class ShareReviewVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewCosmos: CosmosView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var viewText: UIView!
    @IBOutlet weak var btnLoginRef: UIButton!
    
    var id = String()
    var order_id = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    //MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    
    //TODO: View Will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetup()
        
    }
    
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
       
        validation()
        
    }
    
}
