//
//  NotificationsTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 22/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
