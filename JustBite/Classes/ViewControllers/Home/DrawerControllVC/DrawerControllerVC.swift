//
//  DrawerControllerVC.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class DrawerControllerVC: BaseViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var tblViewDrawer: UITableView!
  
     @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var heightHeader: NSLayoutConstraint!
    
    
    //MARK: - Varibles for class
  
    internal var leftModel: LeftModeling?
    internal var dataStore = [LeftMenuStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    

    //TODO: View will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationSetUP()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.topView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if MAIN_SCREEN_HEIGHT == 812 || MAIN_SCREEN_HEIGHT == 896{
            heightHeader.constant = 90
        }else{
            heightHeader.constant = 90
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
     //   navigationSetUP()
    }
    
    
    @objc func tapSectionBtn(sender:UIButton){
        super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
        
    }

}
