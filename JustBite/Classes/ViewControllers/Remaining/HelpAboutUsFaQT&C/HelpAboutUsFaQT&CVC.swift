//
//  HelpAboutUsFaQT&CVC.swift
//  JustBite
//
//  Created by Aman on 11/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import WebKit

class HelpAboutUsFaQT_CVC: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblContent: UILabel!
    var comingFrom = String()
    
    let macroObj = MacrosForAll.sharedInstanceMacro
    
    var webView : WKWebView!
    var weblinks = String()
    //MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        
    }
    
    //TODO: View Will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationSetup()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
}

