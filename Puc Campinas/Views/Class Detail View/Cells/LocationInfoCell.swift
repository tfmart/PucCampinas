//
//  LocationInfoCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 03/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit

class LocationInfoCell: UITableViewCell {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoBackgroundView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationIconImageView: UIImageView!
    
    var delegate: SelectedCellDelegate?
    
    func initialize(title: String, latitude: Double, longitude: Double, building: String) {
        setupInfoBackground()
        locationLabel.text = title
        setupLocationButton()
        mapView.setMapRegion(with: latitude, and: longitude, title: building)
    }
    
    fileprivate func setupInfoBackground() {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = infoBackgroundView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        infoBackgroundView.backgroundColor = .clear
        infoBackgroundView.addSubview(blurEffectView)
        infoBackgroundView.addSubview(locationLabel)
        infoBackgroundView.addSubview(locationIconImageView)
    }
    
    fileprivate func setupLocationButton() {
        let locationViewPressed = UITapGestureRecognizer(target: self, action: #selector(mapViewPressed(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(locationViewPressed)
    }
    
    @objc fileprivate func mapViewPressed(_ sender: UITapGestureRecognizer) {
        self.delegate?.selectedItem(self.mapView.region)
    }
}
