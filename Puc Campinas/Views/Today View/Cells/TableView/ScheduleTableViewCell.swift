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
    
    var schedule: [Subject]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scheduleCollectionView.delegate = self
        scheduleCollectionView.dataSource = self
        scheduleCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate

extension ScheduleTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedule?.count ?? 0
    }
}

//MARK: - UICollectionViewDataSource

extension ScheduleTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTodayScheduleCollectionCell, for: indexPath) as? ScheduleCollectionViewCell else {
            return  UICollectionViewCell()
        }
        cell.initialize(withSchedule: schedule?[indexPath.row])
        cell.todayCellStyle()
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
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
                cell.layer.cornerRadius = 8.0
                cell.backgroundColor = .placeholderText
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .identity
                cell.backgroundColor = .systemBackground
            }
        }
    }
}
