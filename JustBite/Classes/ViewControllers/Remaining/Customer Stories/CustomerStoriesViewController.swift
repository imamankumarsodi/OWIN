//
//  CustomerStoriesViewController.swift
//  OWIN
//
//  Created by apple on 30/03/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit

class CustomerStoriesViewController:BaseViewController {

    @IBOutlet weak var storiesTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storiesTV.delegate = self
        storiesTV.dataSource = self
        storiesTV.separatorColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationSetUp()
    }
   
}


extension CustomerStoriesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomerStoriesTableViewCell = storiesTV.dequeueReusableCell(withIdentifier: CustomerStoriesTableViewCell.className, for: indexPath) as! CustomerStoriesTableViewCell
        
        cell.customerImg.image = UIImage(named: "user_b")
        cell.customerName.text = "Prashant Chaudhary"
        cell.customerDescription.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
          return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
