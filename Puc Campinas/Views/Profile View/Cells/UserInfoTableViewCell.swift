//
//  UserInfoTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 11/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var quarterLabel: UILabel!
    @IBOutlet weak var shiftLabel: UILabel!
    
    
    func initialize(name: String, ra: String, course: String, quarter: Int, shift: String) {
        nameLabel.text = name
        idLabel.text = ra
        courseLabel.text = course
        quarterLabel.text = "\(quarter)º Período"
        shiftLabel.text = shift
    }
}
