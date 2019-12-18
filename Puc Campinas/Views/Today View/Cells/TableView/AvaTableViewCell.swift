//
//  AvaTableViewCell.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 13/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import Foundation
import UIKit
import PuccSwift

class AvaTableViewCell: UITableViewCell  {
    @IBOutlet weak var avaCollectionView: UICollectionView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var avaSites: [AvaSite]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avaCollectionView.delegate = self
        avaCollectionView.dataSource = self
        avaCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate

extension AvaTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avaSites?.count ?? 0
    }
}

//MARK: - UICollectionViewDataSource

extension AvaTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTodayAvaCollectionCell, for: indexPath) as? AvaCollectionViewCell else {
            return  UICollectionViewCell()
        }
        cell.initialize(withAvaSite: avaSites?[indexPath.row])
        cell.todayCellStyle()
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AvaTableViewCell: UICollectionViewDelegateFlowLayout {
    //Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 275, height: 87)
//        return CGSize(width: 344, height: 109)
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
                cell.backgroundColor = UIColor(named: "TodayCollectionViewCellColor")
            }
        }
    }
}
