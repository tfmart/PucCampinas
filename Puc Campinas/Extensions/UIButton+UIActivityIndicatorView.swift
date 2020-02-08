//
//  UIButton+UIActivityIndicatorView.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 13/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit

extension UIButton {
    func showLoading() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        activityIndicator.tag = 8
        self.titleLabel?.removeFromSuperview()
        self.isEnabled = false
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            if let indicator = self.viewWithTag(8) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
            self.isEnabled = true
            self.addSubview(self.titleLabel!)
        }
        
    }
}

extension UITableView {
    func showLoading() {
        let activityIndicator = UIActivityIndicatorView()
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        self.backgroundView = loadingView
    }
    
    func hideLoading() {
        self.backgroundView = nil
    }
}
