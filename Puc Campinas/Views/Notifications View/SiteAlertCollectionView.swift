//
//  SiteAlertCollectionView.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 23/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class SiteAlertCollectionView: UIView, UICollectionViewDelegateFlowLayout {
    
    var siteAlerts: [Alert]?
    var alertCollectionView: UICollectionView!
    var cellID = "alertCollectionViewCell"
    var silentLoginURL: String?
    weak var delegate: SelectedCellDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collectionViewLayout.itemSize = CGSize(width: self.frame.width, height: 700)
        collectionViewLayout.scrollDirection = .horizontal
        alertCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewLayout)
        alertCollectionView.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        alertCollectionView.dataSource = self
        alertCollectionView.delegate = self
        alertCollectionView.register(SiteAlertCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        alertCollectionView.showsHorizontalScrollIndicator = false
        alertCollectionView.reloadData()
        self.addSubview(alertCollectionView)
    }
}

extension SiteAlertCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return siteAlerts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = alertCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SiteAlertCollectionViewCell
        if let alert = siteAlerts?[indexPath.row] {
            cell.alert = alert
            cell.initialize(alert: alert)
            cell.todayCellStyle()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 103)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let alert = siteAlerts?[indexPath.row],
            let alertLink = alert.alertLink,
            let silentLogin = self.silentLoginURL else { return }
        let alertUrl = "\(silentLogin)\(alertLink)"
        self.delegate?.selectedItem(alertUrl)
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

class SiteAlertCollectionViewCell: UICollectionViewCell {
    var alert: Alert?
    let cellFrame = CGRect(x: 0, y: 0, width: 340, height: 103)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initialize(alert: Alert) {
        self.alert = alert
        self.backgroundColor = UIColor(named: "TodayCollectionViewCellColor")
        guard let imageView = alertImageView else { return }
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var alertImageView: UIImageView? {
        guard let alert = self.alert, let image = alert.image, let imageURL = URL(string: image) else { return nil }
        let imageView = UIImageView(frame: cellFrame)
        imageView.download(from: imageURL)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        return imageView
    }
}
