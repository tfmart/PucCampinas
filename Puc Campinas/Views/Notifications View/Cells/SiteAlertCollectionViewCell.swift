//
//  SiteAlertCollectionViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 27/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class SiteAlertCollectionViewCell: UICollectionViewCell {
    var alert: Alert?
    let cellFrame = CGRect(x: 0, y: 0, width: 340, height: 103)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initialize(alert: Alert) {
        self.alert = alert
        self.backgroundColor = UIColor(named: "TodayCollectionViewCellColor")
        guard let imageView = alertImageView else { return }
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var alertImageView: UIImageView? {
        guard let alert = self.alert, let image = alert.image, let imageURL = URL(string: image) else { return nil }
        let imageView = UIImageView(frame: cellFrame)
        imageView.download(from: imageURL)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        return imageView
    }
}
