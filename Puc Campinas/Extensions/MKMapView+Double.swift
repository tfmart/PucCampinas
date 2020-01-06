//
//  MKMapView+Double.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 05/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import MapKit
import PuccSwift

extension MKMapView {
    func setMapRegion(with subject: Subject) {
        let pinTitle = "Prédio \(subject.building?.formatTitle() ?? "")"
        guard let latitude = subject.latitude, let longitude = subject.longitude,
            let latitudeValue = Double(latitude), let longitudeValue = Double(longitude) else { return }
        setMapRegion(with: latitudeValue, and: longitudeValue, title: pinTitle)
    }
    
    func setMapRegion(with latitude: Double, and longitude: Double, title: String) {
        let center = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        let classroomPin = MKPointAnnotation()
        self.setRegion(region, animated: false)
        classroomPin.coordinate = center
        classroomPin.title = title
        self.addAnnotation(classroomPin)
    }
}
