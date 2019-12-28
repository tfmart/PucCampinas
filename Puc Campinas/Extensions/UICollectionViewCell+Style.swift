//
//  CALayer+Shadow.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Layer

extension UICollectionViewCell {
    func todayCellStyle() {
        self.layer.cornerRadius = 8.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
        self.layer.shadowPath = nil
    }
}

//MARK: - Animation

extension UICollectionViewCell  {
    func hightlightAnimation() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                        
        }, completion: nil)
    }
    
    func unhighlightAnimation() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.2,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = .identity
        }, completion: nil)
    }
}
