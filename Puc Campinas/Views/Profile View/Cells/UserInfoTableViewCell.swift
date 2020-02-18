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
    @IBOutlet weak var shiftImageView: UIImageView!
    
    
    func initialize(name: String, ra: String, course: String, quarter: Int?, shift: String) {
        nameLabel.text = name
        idLabel.text = ra
        courseLabel.text = course
        quarterLabel.text = quarter != nil ? "\(quarter!)º Período" : "Período desconhecido"
        shiftLabel.text = shift
        switch CourseShift(shift: shift) {
        case .some(.nocturnal):
            shiftImageView.image = UIImage(systemName: "moon")
        case .some(.morning):
            shiftImageView.image = UIImage(systemName: "sun.min")
        default:
            shiftImageView.image = UIImage(systemName: "sun.max")
        }
    }
}
