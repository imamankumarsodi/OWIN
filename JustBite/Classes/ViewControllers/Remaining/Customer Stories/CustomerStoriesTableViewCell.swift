//
//  CustomerStoriesTableViewCell.swift
//  OWIN
//
//  Created by apple on 30/03/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit

class CustomerStoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var customerImg: UIImageView!
    
    @IBOutlet weak var customerName: UILabel!
    
    @IBOutlet weak var customerDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
