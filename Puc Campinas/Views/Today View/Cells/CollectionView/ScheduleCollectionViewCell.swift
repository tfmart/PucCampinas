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
        locationTimeLabel.text = locationTimeString
        professorLabel.text = self.subject?.professor?.formatTitle()
        attendanceLabel.text = attendanceString
    }
}

extension ScheduleCollectionViewCell {
    var locationTimeString: String {
        guard let startTime = self.subject?.startTime,
            let building = self.subject?.building,
            let room = self.subject?.room else { return "" }
        return "\(startTime) - \(building) SALA \(room)"
    }
    
    var attendanceString: String {
        guard let attendance = self.subject?.attendance else { return "Sem dados de frequencia" }
        return "\(attendance)% de presença"
    }
}
