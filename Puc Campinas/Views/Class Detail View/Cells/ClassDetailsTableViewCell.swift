//
//  ClassDetailsTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit.MKMapView

class ClassDetailsTableViewCell: UITableViewCell {
    //MARK: - @IBOutlets
    
    //Course Info View
    @IBOutlet weak var courseInfoView: UIView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var periodTitleLabel: UILabel!
    
    //Schedule Info View
    @IBOutlet weak var scheduleInfoView: UIView!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    
    //Classroom Info View
    @IBOutlet weak var classroomInfoView: UIView!
    @IBOutlet weak var professorTitleLabel: UILabel!
    @IBOutlet weak var classTitleView: UILabel!
    
    // Location Info View
    @IBOutlet weak var classroomMapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    // Attendance Info View
    @IBOutlet weak var attendanceImageView: UIImageView!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
