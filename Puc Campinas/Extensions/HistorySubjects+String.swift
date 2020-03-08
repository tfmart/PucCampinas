//
//  HistorySubjects+String.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/03/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation
import PuccSwift

extension Sequence where Iterator.Element == HistorySubjects {
    var formattedData: [FormattedHistory] {
        var formattedData: [FormattedHistory] = []
        var subjects: [HistorySubjects] = []
        let years = self.years
        var yearIndex = 0
        
        for subject in self {
            let year = years[yearIndex]
            guard let currentPeriod = subject.period else { break }
            guard currentPeriod == year else {
                formattedData.append(FormattedHistory(year: year, subject: subjects))
                subjects = []
                yearIndex += 1
                subjects.append(subject)
                continue
            }
            subjects.append(subject)
        }
        formattedData.append(FormattedHistory(year: years[yearIndex], subject: subjects))
        
        return formattedData
    }
    
    private var years: [String] {
        var years: [String] = []
        for subject in self {
            if let period = subject.period {
                if !years.contains(period) {
                    years.append(period)
                }
            }
        }
        return years
    }
}

public struct FormattedHistory {
    var year: String
    var subject: [HistorySubjects]
}

