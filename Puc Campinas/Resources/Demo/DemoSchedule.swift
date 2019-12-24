//
//  DemoSchedule.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 24/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import PuccSwift

public class DemoSchedule {
    let schedule: [Subject]
    static public let shared = DemoSchedule()
    private init() {
        schedule = load("ScheduleData.json")
    }
}
