//
//  AttendanceInfoView.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

extension ClassDetailsTableViewCell {
    //MARK: - Properties
    
    var attendanceColor: UIColor {
        guard let attendance = subject?.attendance else {
            return .systemGray
        }
        return (attendance >= 70.0) ? .systemGreen : .systemRed
    }
    
    //MARK: - Setup
    
    func setupAttendanceView() {
        self.attendanceLabel.text = ""
        self.lastUpdatedLabel.text = ""
        attendanceLabel.textColor = attendanceColor
        attendanceImageView.tintColor = attendanceColor
        guard attendanceColor != .systemGray else {
            lastUpdatedLabel.removeFromSuperview()
            //centralize attendanceLabel
            self.attendanceLabel.text = "Sem dados de presença"
            return
        }
        if let attendedClasses = subject?.attendedClasses, let total = subject?.amountClasses {
            self.attendanceLabel.text = "\(attendedClasses) de \(total) aulas presenciadas"
        }
        if let lastUpdate = subject?.lastAttendanceUpdate {
            let lastUpdateString = getLastAttendanceUpdate(date: lastUpdate)
            self.lastUpdatedLabel.text = "atualizado em \(lastUpdateString)"
        }
        
    }
    
    //MARK: - Helpers
    
    func getLastAttendanceUpdate(date: String) -> String {
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        apiDateFormatter.locale = Locale(identifier: "pt_BR")
        let dateFromAPI = apiDateFormatter.date(from: date)
        let attendanceDateFormmater = DateFormatter()
        attendanceDateFormmater.dateFormat = "MMM/y"
        attendanceDateFormmater.locale = Locale(identifier: "pt_BR")
        let attendanceDate = attendanceDateFormmater.string(from: dateFromAPI!)
        return attendanceDate
    }
}
