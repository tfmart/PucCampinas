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
    var region: MKCoordinateRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.region = region
        view.addSubview(mapView)
    }
}
