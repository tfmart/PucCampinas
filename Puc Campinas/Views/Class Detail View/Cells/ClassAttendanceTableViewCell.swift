//
//  ClassAttendanceTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 04/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import MKRingProgressView

class ClassAttendanceTableViewCell: UITableViewCell {
    
    var attendanceRing: RingProgressView!
    
    @IBOutlet weak var progressRing: UIView!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    func initialize(percentage: Float?, attendedAmount: String?, totalAmount: String?, lastUpdate: String?) {
        guard let percentage = percentage, totalAmount != "0" else {
            attendanceLabel.text = "Sem histórico de frequência"
            attendanceLabel.textColor = .systemGray
            setupProgressRing(with: .systemGray)
            self.attendanceRing.progress = 0.0
            lastUpdateLabel.text = " "
            return
        }
        guard let attendance = attendedAmount, let total = totalAmount else {
            attendanceLabel.text = "\(percentage) de presença"
            lastUpdateLabel.text = lastUpdate
            return
        }
        attendanceLabel.text = "\(attendance) de \(total) aulas presenciadas"
        attendanceLabel.textColor = percentage > 70.0 ? .systemGreen : .systemRed
        setupProgressRing(with: attendanceLabel.textColor)
        guard let lastUpdate = lastUpdate, !lastUpdate.isEmpty else {
            lastUpdateLabel.text = "Sem histórico de frequência"
            setupProgressRing(with: .systemGray)
            self.attendanceRing.progress = 0.0
            lastUpdateLabel.text = " "
            return
        }
        lastUpdateLabel.text = "atualizado em \(lastUpdate)"
        self.attendanceRing.progress = Double(percentage)/100
    }
    
    private func setupProgressRing(with color: UIColor) {
        attendanceRing = RingProgressView(frame: CGRect(x: 0, y: 0, width: progressRing.bounds.width, height: progressRing.bounds.height))
        attendanceRing.progress = 0
        attendanceRing.startColor = color
        attendanceRing.endColor = color
        attendanceRing.shadowOpacity = 0
        attendanceRing.ringWidth = 12.0
        attendanceRing.backgroundColor = .todayCollectionViewCell
        progressRing.addSubview(attendanceRing)
    }
}
