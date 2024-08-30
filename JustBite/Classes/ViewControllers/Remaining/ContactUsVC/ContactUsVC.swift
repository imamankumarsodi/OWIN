//
//  ContactUsVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class ContactUsVC: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblContact: UITableView!
    
    
    
    //MARK: - Varibles for class
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    internal var contactData: ContactUsModeling?
    internal var dataStore = [ContactUsStruct]()
 
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
