//
//  AvaCollectionViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 13/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit
import PuccSwift

class AvaCollectionViewCell: UICollectionViewCell {
    
    var avaSite: AvaSite?
    
    @IBOutlet weak var siteTitleLabel: UILabel!
    @IBOutlet weak var filesIconImageView: UIImageView!
    @IBOutlet weak var filesLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(withAvaSite avaSite: AvaSite?) {
        self.alertLabel.isHidden = true
        self.avaSite = avaSite
        siteTitleLabel.text = self.avaSite?.title?.formatAvaTitle()
        let requester = SiteAlertRequester(configuration: PucConfiguration.shared, siteId: avaSite?.id ?? "") { (avaEntity, requestToken, error) in
            guard let avaEntity = avaEntity, let alerts = avaEntity.announcementCollection, alerts.count > 0 else {
                return
            }
            DispatchQueue.main.async {
                self.alertLabel.isHidden = false
                self.alertLabel.layer.masksToBounds = true
                self.alertLabel.layer.cornerRadius = 10
                self.alertLabel.text = "\(alerts.count)"
            }
        }
        requester.start()
    }
}

