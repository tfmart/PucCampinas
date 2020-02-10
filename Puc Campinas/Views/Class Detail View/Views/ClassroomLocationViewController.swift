//
//  ClassroomLocationViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 05/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit

class ClassroomLocationViewController: UIViewController {
    let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
