//
//  AccessibilityConfiguration.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 23/05/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class AccessibilityConfiguration {
    
    class func setup(cell: ScheduleCollectionViewCell, withSubject subject: Subject) {
        cell.classTitleLabel.isAccessibilityElement = false
        cell.locationTimeLabel.isAccessibilityElement = false
        cell.professorIconImageView.isAccessibilityElement = false
        cell.professorLabel.isAccessibilityElement = false
        cell.attendanceIconImageView.isAccessibilityElement = false
        cell.attendanceLabel.isAccessibilityElement = false
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = subject.accessibilityDescription
    }
}

extension Subject {
    var accessibilityName: String? {
        if self.name?.hasPrefix("PF") ?? false {
            return (self.name?.replacingOccurrences(of: "PF-", with: "Prática de Formação: "))
        } else {
            return self.name
        }
    }
    
    var accessibilityAttendance: String {
        if let attendance = self.attendance {
            return "\(attendance) por cento de presença"
        } else {
            return "Sem dados de frequência"
        }
    }
    
    var accessibilityBuilding: String? {
        if building?.hasPrefix("Cent. Tecn") ?? false {
            return "Centro Técnico"
        } else {
            return building
        }
    }
    
    var accessibilityDescription: String? {
        return "\(accessibilityName ?? "Aula"), das \(time ?? ""), no prédio \(accessibilityBuilding ?? "desconhecido"), sala \(accessibilityBuilding ?? ""). \(accessibilityAttendance)"
    }
}
