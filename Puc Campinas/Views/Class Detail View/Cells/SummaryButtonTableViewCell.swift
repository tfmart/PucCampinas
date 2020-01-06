//
//  SummaryButtonTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class SummaryButtonTableViewCell: UITableViewCell {

    var summary: String?
    weak var delegate: SelectedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func summaryButtonPressed(_ sender: Any) {
        self.delegate?.selectedItem(summary ?? "")
    }
    
}
