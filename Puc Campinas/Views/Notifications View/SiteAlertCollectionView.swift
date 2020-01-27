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
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLayout.itemSize = CGSize(width: self.frame.width, height: 700)
        collectionViewLayout.scrollDirection = .horizontal
        alertCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewLayout)
        alertCollectionView.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        alertCollectionView.dataSource = self
        alertCollectionView.delegate = self
        alertCollectionView.register(SiteAlertCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
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
        return CGSize(width: 458, height: 144)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let alert = siteAlerts?[indexPath.row],
            let alertLink = alert.alertLink,
            let silentLogin = self.silentLoginURL else { return }
        let alertUrl = "\(silentLogin)\(alertLink)"
        self.delegate?.selectedItem(alertUrl)
    }
}

class SiteAlertCollectionViewCell: UICollectionViewCell {
    var alert: Alert?
    let cellFrame = CGRect(x: 0, y: 0, width: 456, height: 144)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initialize(alert: Alert) {
        self.alert = alert
        guard let imageView = alertImageView else { return }
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var alertImageView: UIImageView? {
        guard let alert = self.alert, let image = alert.image, let imageURL = URL(string: image) else { return nil }
        let imageView = UIImageView(frame: cellFrame)
        imageView.load(url: imageURL)
        return imageView
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
