//
//  String+Formatting.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation

extension String {
    //Formats the strings for the headers
    func formatYear() -> String {
        let semester = String(self.last!)
        let year = String(self.prefix(4))
        let result = "\(year) (\(semester)º Semestre)"
        return result
    }
    
    //Format the taken subject name
    func formatTitle() -> String {
        let capitalizedString = self.capitalized
        var formattedString = capitalizedString.replacingOccurrences(of: " E ", with: " e ")
        formattedString = formattedString.replacingOccurrences(of: " À ", with: " à ")
        formattedString = formattedString.replacingOccurrences(of: " Do ", with: " do ")
        formattedString = formattedString.replacingOccurrences(of: " Dos ", with: " dos ")
        formattedString = formattedString.replacingOccurrences(of: " De ", with: " de ")
        formattedString = formattedString.replacingOccurrences(of: " Da ", with: " da ")
        formattedString = formattedString.replacingOccurrences(of: " Das ", with: " das ")
        formattedString = formattedString.replacingOccurrences(of: " Na ", with: " na ")
        formattedString = formattedString.replacingOccurrences(of: " No ", with: " no ")
        formattedString = formattedString.replacingOccurrences(of: "Pf-", with: "PF - ")
        return formattedString
    }
}
