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
    weak var delegate: TodayViewCellDelegate?
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let avaSite = avaSites?[indexPath.row] else { return }
        self.delegate?.selectedItem(avaSite)
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
