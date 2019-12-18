//
//  CALayer+Shadow.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit

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

extension CALayer {
    func applySketchShadow(
        color: UIColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.1),
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 16,
        blur: CGFloat = 32,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
