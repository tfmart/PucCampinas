//
//  CompleteScheduleTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 28/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class CompleteScheduleTableViewCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK: - Methods
    
    func initialize(with subject: Subject) {
        titleLabel.text = subject.name?.formatTitle()
        timeLabel.text = subject.time
        locationLabel.text = subject.locationString
        professorLabel.text = subject.professor?.formatTitle()
        attendanceLabel.text = subject.attendanceString
    }

    func cellHeight() -> CGFloat {
        return (self.titleLabel.numberOfLines > 0) ? 152 : 128
    }
    
}
