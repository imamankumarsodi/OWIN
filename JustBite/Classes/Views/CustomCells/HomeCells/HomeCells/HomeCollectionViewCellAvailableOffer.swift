//
//  HomeCollectionViewCellAvailableOffer.swift
//  JustBite
//
//  Created by Aman on 09/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class HomeCollectionViewCellAvailableOffer: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    public func configureCellWith(info: RestaurentDataModelForHome){
        self.imgView.sd_setImage(with: URL(string: info.img), placeholderImage: UIImage(named: "user_signup"))
    }
    
}
