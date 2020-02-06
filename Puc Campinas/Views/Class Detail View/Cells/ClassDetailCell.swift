//
//  ClassDetailCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 03/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class ClassDetailCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    
    func initalize(_ type: DetailCellType, firstDescription: String, secondDescription: String) {
        firstDescriptionLabel.text = firstDescription
        secondDescriptionLabel.text = secondDescription
        switch type {
        case .courseInfo:
            firstTitleLabel.text = "CURSO"
            secondTitleLabel.text = "PERÍODO"
            iconImageView.image = UIImage(systemName: "house.fill")
            iconImageView.tintColor = .systemGray
            break
        case .schedule:
            firstTitleLabel.text = "HORÁRIO"
            secondTitleLabel.text = "DATA"
            iconImageView.image = UIImage(systemName: "clock.fill")
            iconImageView.tintColor = .systemBlue
            break
        case .classroom:
            firstTitleLabel.text = "PROFESSOR(A)"
            secondTitleLabel.text = "TURMA"
            iconImageView.image = UIImage(systemName: "person.fill")
            iconImageView.tintColor = .systemGreen
            break
        default:
            break
        }
    }
    
}
