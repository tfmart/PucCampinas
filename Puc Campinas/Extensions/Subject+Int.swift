//
//  Subject+Int.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 24/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import PuccSwift

extension Sequence where Iterator.Element == Subject {
    func todayClasses() -> [Subject] {
        guard let today = todayDayOfWeek() else {
            return []
        }
        return classes(forDay: today)
    }
    
    func classes(forDay day: Int) -> [Subject] {
        var todayClasses: [Subject] = []
        for subject in self {
            if subject.dayWeek == day {
                todayClasses.append(subject)
            }
        }
        return todayClasses
    }
    
    private func todayDayOfWeek() -> Int? {
        let currentDate = Date()
        let dayString = currentDate.shortDayOfWeek()
        switch dayString {
        case "Dom":
            return 1
        case "Seg":
            return 2
        case "Ter":
            return 3
        case "Qua":
            return 4
        case "Qui":
            return 5
        case "Sex":
            return 6
        case "Sáb":
            return 7
        default: return nil
        }
    }
}
