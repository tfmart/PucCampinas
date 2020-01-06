//
//  AvaHomeTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit
import PuccSwift

class AvaHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var siteTitleLabel: UILabel!
    @IBOutlet weak var fileIconImageView: UIImageView!
    @IBOutlet weak var fileLabel: UILabel!
    @IBOutlet weak var alertIconImageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    
    func initialize(withSite avaSite: AvaSite?) {
        self.siteTitleLabel.text = avaSite?.title?.formatAvaTitle()
        //TO-DO: Request for files
        self.fileLabel.text = "0 arquivos"
        self.alertLabel.text = ""
        self.alertIconImageView.tintColor = .darkGray
        let requester = SiteAlertRequester(configuration: PucConfiguration.shared, siteId: avaSite?.id ?? "") { (avaEntity, requestToken, error) in
            DispatchQueue.main.async {
                guard let avaEntity = avaEntity, let alerts = avaEntity.announcementCollection, alerts.count > 0 else {
                    self.alertLabel.text = "Sem alertas recentes"
                    return
                }
                self.alertIconImageView.tintColor = .systemRed
                self.alertLabel.text = "\(alerts.count) alertas recentes"
            }
        }
        requester.start()
    }
}
