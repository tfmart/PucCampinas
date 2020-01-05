//
//  CourseInfoView.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

extension ClassDetailsTableViewCell {
    //MARK: - Setup
    
    func setupInfoViews() {
        setupCourseInfoView()
        setupScheduleInfoView()
        setupClassroomInfoView()
    }
    
    func setupCourseInfoView() {
        guard let course = subject?.courseName, let period = subject?.turn else {
            courseInfoView.removeFromSuperview()
            return
        }
        courseTitleLabel.text = course.formatTitle()
        periodTitleLabel.text = period
    }
    
    func setupScheduleInfoView() {
        guard let schedule = subject?.time, let date = subject?.duration else {
            scheduleInfoView.removeFromSuperview()
            return
        }
        timeTitleLabel.text = schedule
        dateTitleLabel.text = date
    }
    
    func setupClassroomInfoView() {
        guard let professor = subject?.professor, let classCode = subject?.classroom else {
            classroomInfoView.removeFromSuperview()
            return
        }
        professorTitleLabel.text = professor
        classTitleLabel.text = classCode
    }
}
