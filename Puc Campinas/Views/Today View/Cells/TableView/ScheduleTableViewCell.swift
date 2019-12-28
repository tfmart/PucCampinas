//
//  ScheduleTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 13/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit
import PuccSwift

class ScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var emptyScheduleLabel: UILabel!
    
    var schedule: [Subject]?
    var todaysSchedule: [Subject]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scheduleCollectionView.delegate = self
        scheduleCollectionView.dataSource = self
        scheduleCollectionView.reloadData()
    }
    
    //MARK: - Methods

    func setLabels() {
        self.headerLabel?.text = ""
        self.emptyScheduleLabel.text = ""
        guard let amount = self.todaysSchedule?.count else { return }
        switch amount {
        case 0:
            if self.schedule?.count == 0 {
                self.emptyScheduleLabel.text = "Parece que você está de férias!"
            } else {
                self.emptyScheduleLabel.text = "Aproveite o seu dia!"
            }
            self.headerLabel?.text = "Sem aulas por hoje"
        case 1:
            self.headerLabel?.text = "Você tem 1 aula hoje"
        default:
            self.headerLabel?.text = "Você tem \(amount) aulas hoje"
        }
    }
}

//MARK: - UICollectionViewDelegate

extension ScheduleTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todaysSchedule?.count ?? 0
    }
}

//MARK: - UICollectionViewDataSource

extension ScheduleTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTodayScheduleCollectionCell, for: indexPath) as? ScheduleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.initialize(withSchedule: todaysSchedule?[indexPath.row])
        cell.todayCellStyle()
        self.setLabels()
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ScheduleTableViewCell: UICollectionViewDelegateFlowLayout {
    //Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 275, height: 112)
//        return CGSize(width: 344, height: 140)
    }
    
    //Animation
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.hightlightAnimation()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.unhighlightAnimation()
        }
    }
}
