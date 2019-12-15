//
//  ScheduleButtonTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 13/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit

class ScheduleButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var fullScheduleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fullScheduleButton.layer.cornerRadius = 8.0
    }
}
