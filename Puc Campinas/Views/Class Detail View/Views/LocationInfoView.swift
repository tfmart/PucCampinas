//
//  LocationInfoView.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 05/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit

extension ClassDetailsTableViewCell {
    //MARK: - Setup
    
    func setupLocationInfoView() {
        setupLocationLabels()
        setupMapView()
    }
    
    func setupLocationLabels() {
        guard let building = subject?.building, let classroom = subject?.classroom else {
            locationInfoView.removeFromSuperview()
            return
        }
        var locationString = "\(building.formatTitle()) - Sala \(classroom)"
        if let campus = subject?.campus {
            locationString.append(", \(campus.trimmingCharacters(in: .whitespaces))")
        }
        locationLabel.text = locationString
    }
    
    func setupMapView() {
        guard let latitude = subject?.latitude, let longitude = subject?.longitude else {
            classroomMapView.removeFromSuperview()
            return
        }
    }
}
