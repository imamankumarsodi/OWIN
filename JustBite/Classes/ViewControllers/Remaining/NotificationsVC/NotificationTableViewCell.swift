//
//  NotificationTableViewCell.swift
//  JustBite
//
//  Created by cst on 30/01/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notiDesc: UILabel!
    @IBOutlet weak var notiTime: UILabel!
    @IBOutlet weak var notiTitle: UILabel!
    @IBOutlet weak var notiIV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
