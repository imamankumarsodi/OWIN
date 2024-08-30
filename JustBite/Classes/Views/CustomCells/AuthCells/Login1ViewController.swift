//
//  Login1ViewController.swift
//  JustBite
//
//  Created by Aman on 31/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class Login1ViewController: UIViewController {
    //MARK: VAriable
    var counrtyCode = ["+91","+94","+84"]
    var CountryImage = [#imageLiteral(resourceName: "terms_conditions"),#imageLiteral(resourceName: "burger_img_2"),#imageLiteral(resourceName: "mail_in_circle")]
    // MARK: OUTLETS
    
    @IBOutlet weak var counrtyCodetxt: MDCTextField!
    
    @IBOutlet weak var countryCodeImg: UIImageView!
    
    @IBOutlet weak var mobileTxt: MDCTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
