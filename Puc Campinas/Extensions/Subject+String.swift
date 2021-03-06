//
//  Subject+String.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import PuccSwift

extension Subject {
    var startTime: String? {
        guard let time = self.time else { return nil }
        return String(time.prefix(5))
    }
    
    var endTime: String? {
        guard let time = self.time else { return nil }
        return String(time.suffix(5))
    }
    
    var locationString: String {
        guard let building = self.building,
            let room = self.room else { return "" }
        return "\(building.formatTitle()) - Sala \(room)"
    }
    
    var locationWithCampusString: String {
        var location = locationString
        guard !location.isEmpty, let campus = campus else {
            return ""
        }
        location.append(", \(campus.trimmingCharacters(in: .whitespaces))")
        return location
    }
    
    var locationTimeString: String {
        guard let startTime = self.startTime,
            let building = self.building?.formatTitle(),
            let room = self.room else { return "" }
        return "\(startTime) - \(building) SALA \(room)"
    }
    
    var attendanceString: String {
        guard let attendance = self.attendance,
            amountClasses != "0" else { return "Sem histórico de frequencia" }
        return "\(attendance)% de presença"
    }
    
    var lastUpdate: String {
        guard let lastAttendanceUpdate = self.lastAttendanceUpdate else {
            return ""
        }
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        apiDateFormatter.locale = Locale(identifier: "pt_BR")
        let dateFromAPI = apiDateFormatter.date(from: lastAttendanceUpdate)
        let attendanceDateFormmater = DateFormatter()
        attendanceDateFormmater.dateFormat = "MMM/y"
        attendanceDateFormmater.locale = Locale(identifier: "pt_BR")
        let attendanceDate = attendanceDateFormmater.string(from: dateFromAPI!)
        return attendanceDate
    }
    
}
