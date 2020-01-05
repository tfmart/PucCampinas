//
//  ClassDetailsTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift
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
    @IBOutlet weak var classTitleLabel: UILabel!
    
    //Location Info View
    @IBOutlet weak var locationInfoView: UIView!
    @IBOutlet weak var classroomMapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    //Attendance Info View
    @IBOutlet weak var attendanceInfoView: UIView!
    @IBOutlet weak var attendanceImageView: UIImageView!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    //MARK: - Properties
    
    var subject: Subject?
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK: - Methods
    
    func initialize() {
        setupInfoViews()
        
        setupAttendanceView()
    }
}
