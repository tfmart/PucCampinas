//
//  Date+Int.swift
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
}
