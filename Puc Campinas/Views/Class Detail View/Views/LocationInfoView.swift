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
        setupLocationButton()
        setupMapView()
    }
    
    fileprivate func setupLocationLabels() {
        guard subject?.building != nil, subject?.classroom != nil else {
            locationInfoView.removeFromSuperview()
            return
        }
        locationLabel.text = subject?.locationWithCampusString
    }
    
    fileprivate func setupMapView() {
        if let subject = subject {
            classroomMapView.setMapRegion(with: subject)
        }
    }
    
    fileprivate func setupLocationButton() {
        let locationViewPressed = UITapGestureRecognizer(target: self, action: #selector(mapViewPressed(_:)))
        locationInfoView.isUserInteractionEnabled = true
        locationInfoView.addGestureRecognizer(locationViewPressed)
    }

    @objc fileprivate func mapViewPressed(_ sender: UITapGestureRecognizer) {
        self.delegate?.selectedItem(subject!)
    }
    
    fileprivate func setupInfoBackground() {
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
