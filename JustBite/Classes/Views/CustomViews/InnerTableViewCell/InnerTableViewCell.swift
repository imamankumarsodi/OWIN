//
//  InnerTableViewCell.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class InnerTableViewCell: SBaseTableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnCustomizeRef: UIButton!
    @IBOutlet weak var imgSymbol: UIImageView!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  configure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
}
