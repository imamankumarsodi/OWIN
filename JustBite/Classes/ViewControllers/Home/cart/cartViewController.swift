//
//  cartViewController.swift
//  JustBite
//
//  Created by cst on 03/02/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit

class cartViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       initialSetUp()
    }
  
    //TODO: View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationSetUp()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }

}
