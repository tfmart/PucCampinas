//
//  ClassroomLocationViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 05/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit
import PuccSwift

class ClassroomLocationViewController: UIViewController {
    
    let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var latitude: Double?
    var subject: Subject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        view.addSubview(mapView)
    }
    
    func setupMapView() {
        if let subject = subject {
            mapView.setMapRegion(with: subject)
        }
    }
}
