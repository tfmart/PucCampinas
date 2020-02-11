//
//  UITableView+EmptyStateView.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 09/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyState(with message: String) {
        self.hideLoading()
        self.backgroundView = EmptyStateView(message: message, frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
    }
}
