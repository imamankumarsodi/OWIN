//
//  FilterTableViewCell.swift
//  JustBite
//
//  Created by cst on 31/01/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var itemsCV: UICollectionView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var selectorBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
