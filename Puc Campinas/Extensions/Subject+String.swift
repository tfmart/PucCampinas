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
    
}
