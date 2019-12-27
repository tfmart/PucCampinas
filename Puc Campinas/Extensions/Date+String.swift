//
//  Date+String.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 24/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation

extension Date {
    func shortDayOfWeek() -> String? {
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "EEE"
        weekFormatter.locale = Locale(identifier: "pt_BR")
        let dayString = "\(weekFormatter.string(from: self).capitalized)"
        return dayString
    }
    
    func scheduleDateTitle() -> String? {
        let firstFormatter = DateFormatter()
        firstFormatter.dateFormat = "EEEE, dd"
        firstFormatter.locale = Locale(identifier: "pt_BR")
        let secondFormatter = DateFormatter()
        secondFormatter.dateFormat = "MMMM"
        secondFormatter.locale = Locale(identifier: "pt_BR")
        let dateTitle = "\(firstFormatter.string(from: self).capitalized) de \(secondFormatter.string(from: self))"
        return dateTitle
    }
}
