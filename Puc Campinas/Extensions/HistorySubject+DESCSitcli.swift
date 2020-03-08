//
//  HistorySubject+DESCSitcli.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 08/03/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation
import PuccSwift

extension HistorySubjects {
    var description: DECSitcli {
        switch self.situation {
        case "5":
            return .suficienteAprovado
        case "3":
            return .satisfatorioAprovado
        case "A":
            return .aprovado
        case "R", "Rf":
            return .reporvado
        default:
            return .reporvado
        }
    }
}
