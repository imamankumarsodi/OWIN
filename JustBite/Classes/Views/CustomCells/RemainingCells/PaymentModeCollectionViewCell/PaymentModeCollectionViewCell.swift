//
//  PaymentModeCollectionViewCell.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class PaymentModeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCard: UIImageView!
    
    @IBOutlet weak var btnDeleteRef: UIButton!
    
    @IBOutlet weak var lblCardNo: UILabel!
    
    @IBOutlet weak var lblCardName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblCardName.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        lblCardNo.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 16)
        lblDate.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
        
    }
    func configureWith(data:CardModel) {
        lblCardName.text = data.card_name
        
        var strString = String()
        let chars = Array(data.card_number)
        print(chars)
        for index in 0..<chars.count{
            if index >= (chars.count - 4){
        strString.append(chars[index])
            }else{
                strString.append("X")
            }
        }
        
        lblCardNo.text = strString
        lblDate.text = "\(data.card_exp_month)/\(data.card_exp_year)"
    }

}
