//
//  SummaryButtonCell.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 11/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class SummaryButtonCell: UITableViewCell {
    var summaryButton: UIButton!
    weak var delegate: SelectedCellDelegate!
    var summary: String?
    
    func initialize(with summary: String?) {
        setupButton()
        self.summary = summary
    }
    
    private func setupButton() {
        summaryButton = UIButton(type: .roundedRect)
        summaryButton.setTitle("Ver ementa", for: .normal)
        summaryButton.setTitleColor(.label, for: .normal)
        summaryButton.titleLabel?.textAlignment = .center
        summaryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        summaryButton.frame = self.contentView.bounds
        summaryButton.autoresizingMask = .flexibleWidth
        summaryButton.addTarget(self, action: #selector(summaryButtonPressed), for: .touchDown)
        self.addSubview(summaryButton)
    }
    
    @objc func summaryButtonPressed() {
        if let summary = self.summary {
            self.delegate?.selectedItem(summary)
        }
    }
}
