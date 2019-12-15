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
        self.avaSite = avaSite
        siteTitleLabel.text = self.avaSite?.title?.formatTitle()
    }
}

