//
//  HomeTableViewCell.swift
//  JustBite
//
//  Created by Aman on 09/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import Cosmos

class HomeTableViewCell: SBaseTableViewCell {

    
    //MARK: - IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var imgResaurent: UIImageView!
    @IBOutlet weak var viewCosmos: CosmosView!
    @IBOutlet weak var lblRatingReview: UILabel!
    @IBOutlet weak var btnFavRef: UIButton!
    
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var disLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
}


//MARK:- Extension Homet
