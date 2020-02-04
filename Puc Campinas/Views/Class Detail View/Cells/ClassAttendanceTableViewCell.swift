//
//  ClassAttendanceTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 04/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class ClassAttendanceTableViewCell: UITableViewCell {
    @IBOutlet weak var progressRing: UIImageView!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    func initialize(percentage: Float?, attendedAmount: String?, totalAmount: String?, lastUpdate: String?) {
        guard let percentage = percentage else {
            attendanceLabel.text = "Sem dados de frequência"
            attendanceLabel.textColor = .systemGray
            lastUpdateLabel.text = ""
            return
        }
        guard let attendance = attendedAmount, let total = totalAmount else {
            attendanceLabel.text = "\(percentage) de presença"
            lastUpdateLabel.text = lastUpdate ?? ""
            return
        }
        attendanceLabel.text = "\(attendance) de \(total) aulas presenciadas"
        attendanceLabel.textColor = percentage > 70.0 ? .systemGreen : .systemRed
        progressRing.tintColor = attendanceLabel.textColor
        guard let lastUpdate = lastUpdate else {
            lastUpdateLabel.text = ""
            return
        }
        lastUpdateLabel.text = "atualizado em \(lastUpdate)"
    }
}
