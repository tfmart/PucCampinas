//
//  NavigationItem+Subtitle.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 25/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit

extension TodayViewController {
    func setTitle(title:String, subtitle:String) -> UIView {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        
        //Get navigation Bar Height and Width
        let navigationBarHeight = Int(self.navigationController!.navigationBar.frame.height)
        let navigationBarWidth = Int(self.navigationController!.navigationBar.frame.width)

        //Set Font size and weight for Title and Subtitle
        let subTitleFont = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)

        //SubTitle label
        let subtitleLabel = UILabel(frame: CGRect(x: 8.5, y: 24, width: 0, height: 0))
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = subTitleFont
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        subtitleLabel.adjustsFontForContentSizeCategory = true

        //Add Title and Subtitle to View
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: navigationBarWidth, height: navigationBarHeight))
        self.navigationItem.title = title
        titleView.addSubview(subtitleLabel)

        return titleView

    }
}
