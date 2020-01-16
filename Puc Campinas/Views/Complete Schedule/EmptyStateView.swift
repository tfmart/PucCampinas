//
//  EmptyStateView.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 14/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    init(message: String, frame: CGRect) {
        super.init(frame: frame)
        let emptyView =  UIView(frame: frame)
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: emptyView.frame.width / 2, height: emptyView.frame.height / 2))
        messageLabel.text = message
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.center = CGPoint(x: emptyView.frame.width / 2.0, y: emptyView.frame.height / 2.0)
        emptyView.addSubview(messageLabel)
        emptyView.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        self.addSubview(emptyView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
