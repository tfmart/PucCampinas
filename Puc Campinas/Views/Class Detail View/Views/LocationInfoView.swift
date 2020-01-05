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
        setupInfoBackground()
        setupMapView()
    }
    
    fileprivate func setupLocationLabels() {
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
    
    fileprivate func setupMapView() {
        guard let latitude = subject?.latitude, let longitude = subject?.longitude,
            let latitudeValue = Double(latitude), let longitudeValue = Double(longitude) else {
                classroomMapView.removeFromSuperview()
                return
        }
        let center = CLLocationCoordinate2D.init(latitude: latitudeValue, longitude: longitudeValue)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        let classroomPin = MKPointAnnotation()
        classroomMapView.setRegion(region, animated: false)
        classroomPin.coordinate = center
        classroomPin.title = "Prédio \(subject?.building?.formatTitle() ?? "")"
        classroomMapView.addAnnotation(classroomPin)
    }
    
    fileprivate func setupInfoBackground() {
//        locationLabel.removeFromSuperview()
//        locationIconImageView.removeFromSuperview()
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = locationInfoBackground.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        locationInfoBackground.backgroundColor = .clear
        locationInfoBackground.addSubview(blurEffectView)
        locationInfoBackground.addSubview(locationIconImageView)
        locationInfoBackground.addSubview(locationLabel)
    }
}
