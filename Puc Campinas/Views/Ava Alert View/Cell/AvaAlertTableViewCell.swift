//
//  AvaAlertTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 09/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class AvaAlertTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    weak var delegate: SelectedCellDelegate!
    
    func initialize(title: String, author: String, description: String) {
        titleLabel.text = title
        authorLabel.text = author
        styleMessage(body: description)
        descriptionTextView.textContainer.heightTracksTextView = true
        descriptionTextView.delegate = self
    }
    
    func styleMessage(body: String) {
        let data = Data(body.utf8)
        if let alertBody = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            alertBody.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.label], range: NSRange(
            location: 0,
            length: alertBody.length))
            descriptionTextView.attributedText = alertBody
        }
    }
}

extension AvaAlertTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.delegate?.selectedItem(URL)
        return false
    }
}
