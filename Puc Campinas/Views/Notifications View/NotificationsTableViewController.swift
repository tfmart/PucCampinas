//
//  NotificationsTableViewController.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 22/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class NotificationsTableViewController: UITableViewController {
    var notifications: [PucNotification]?
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        getSiteAlerts()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kPucNotificationCell, for: indexPath) as? NotificationsTableViewCell else  {
            return UITableViewCell()
        }
        cell.titleLabel?.text = notifications?[indexPath.row].type?.name
        cell.dateLabel?.text = notifications?[indexPath.row].date
        cell.descriptionLabel?.text = notifications?[indexPath.row].message
        return cell
    }
}

extension NotificationsTableViewController {
    func getSiteAlerts() {
        let requester =  AlertRequester(configuration: PucConfiguration.shared) { (alerts, silentLoginUrl, error) in
            DispatchQueue.main.async {
                guard let alerts = alerts else {
                    let isEmpty = self.notifications?.isEmpty ?? true
                    self.tableView.reloadData()
                    self.tableView.backgroundView = (isEmpty) ? EmptyStateView(message: "Não há notificações",
                                                                               frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width,
                                                                                             height: self.tableView.bounds.height)) : nil
                    self.tableView.alwaysBounceVertical = !isEmpty
                    return
                }
                self.setupAlertCollectionView(with: alerts, silentLoginUrl: silentLoginUrl)
            }
        }
        showLoading()
        requester.start()
    }
    
    func setupAlertCollectionView(with alerts: [Alert]?, silentLoginUrl: String?) {
        let collectionView = SiteAlertCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 123))
        collectionView.siteAlerts = alerts
        collectionView.silentLoginURL = silentLoginUrl
        collectionView.delegate = self
        self.tableView.tableFooterView = collectionView
        self.tableView.reloadData()
        self.tableView.backgroundView = nil
        collectionView.alertCollectionView.reloadData()
    }
    
    func showLoading() {
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        self.tableView.backgroundView = loadingView
    }
}

extension NotificationsTableViewController: SelectedCellDelegate {
    func selectedItem(_ item: Any) {
        if let alertLink = item as? String {
            let webView = AvaWebViewController()
            webView.url = alertLink
            self.navigationController?.pushViewController(webView, animated: true)
            
        }
    }
}
