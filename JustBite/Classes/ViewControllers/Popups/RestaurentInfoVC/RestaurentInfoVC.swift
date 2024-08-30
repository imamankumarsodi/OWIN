//
//  RestaurentInfoVC.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import DropDown

class RestaurentInfoVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblAddOns: UITableView!
    
    
    //MARK: - Variables
    internal var previousOffset: CGFloat = 0
    var viewC = UIViewController()
    var id = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var timeArray = [String]()
    let dropDown = DropDown()
    var reviewDataModelArray = [RestaurentReviewModel]()
    
    let header:RestInfoHeader = Bundle.main.loadNibNamed("RestInfoHeader", owner: self, options: nil)!.first! as! RestInfoHeader
    
    //MARK: - View Life Cycle Methods
    //TODO: View didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initialStup()
        // Do any additional setup after loading the view.
    }
    
    //TODO: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        super.hideStatusBar(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    //MARK: - Actions,Gesture
    //TODO: Save Actions
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func btnViewAllTapped(sender:UIButton){
        self.dismiss(animated: true) {
            let vc = AppStoryboard.remain.instantiateViewController(withIdentifier: RatingAndReviewsVC.className) as! RatingAndReviewsVC
            vc.id = self.id
            self.viewC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func btnShiftTapped(sender:UIButton){
        dropDown.show()
        
    }
    
    
}
