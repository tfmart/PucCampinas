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
        return "\(building) - Sala \(room)"
    }
    
    var locationTimeString: String {
        guard let startTime = self.startTime,
            let building = self.building,
            let room = self.room else { return "" }
        return "\(startTime) - \(building) SALA \(room)"
    }
    
    var attendanceString: String {
        guard let attendance = self.attendance else { return "Sem dados de frequencia" }
        return "\(attendance)% de presença"
    }
    
}
