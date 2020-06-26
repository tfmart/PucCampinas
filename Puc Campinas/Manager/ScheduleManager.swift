//
//  ScheduleManager.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 25/06/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation
import PuccSwift

public enum PucError: Error {
    case invalidCredentials
    case noSession
}

public class ScheduleManager {
    static var schedule = [Subject]()
    
    static public func fetchSchedule(success: @escaping ([Subject]) -> (), failure: @escaping (PucError) -> ()) {
        let scheduleRequester = ScheduleRequester(configuration: PucConfiguration.shared) { (schedule, requestToken, error) in
            guard let schedule = schedule else {
                failure(.invalidCredentials)
                return
            }
            self.schedule = schedule
            success(schedule)
        }
        scheduleRequester.start()
    }
    
    static public func nextClass() {
        
    }
    
    static func classes(for weekday: Weekday) -> [Subject] {
        return schedule.filter({ $0.dayWeek == weekday.rawValue })
    }
}
