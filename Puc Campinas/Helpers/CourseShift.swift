//
//  CourseShift.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 17/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation

public enum CourseShift {
    case morning
    case afternoon
    case fullTime
    case nocturnal
    
    init?(shift: String) {
        if shift.hasPrefix("Integral") {
            self = .fullTime
        } else if shift == "Noturno" {
            self = .nocturnal
        } else if shift == "Matutino" {
            self = .morning
        } else if shift == "Vespertino" {
            self = .afternoon
        } else {
            return nil
        }
    }
}

