//
//  ScheduleCollectionViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 13/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit
import PuccSwift

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    var subject: Subject?
    
    @IBOutlet weak var classTitleLabel: UILabel!
    @IBOutlet weak var locationTimeLabel: UILabel!
    @IBOutlet weak var professorIconImageView: UIImageView!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var attendanceIconImageView: UIImageView!
    @IBOutlet weak var attendanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(withSchedule subject: Subject?) {
        self.subject = subject
        classTitleLabel.text = self.subject?.name?.formatTitle()
        locationTimeLabel.text = self.subject?.locationTimeString.uppercased()
        professorLabel.text = self.subject?.professor?.formatTitle()
        attendanceLabel.text = self.subject?.attendanceString
        guard let attendance = self.subject?.attendance else {
            attendanceIconImageView.tintColor = UIColor.darkGray
            return
        }
        if attendance < 70 {
            attendanceIconImageView.tintColor = UIColor.red
        } else {
            attendanceIconImageView.tintColor = UIColor.systemGreen
        }
    }
}
