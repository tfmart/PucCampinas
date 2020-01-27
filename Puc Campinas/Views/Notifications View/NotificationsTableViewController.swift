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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        setupTableViewState()
        setupSiteAlert()
    }
    
    fileprivate func setupTableViewState() {
        let isEmpty = notifications?.isEmpty ?? true
        self.tableView.reloadData()
        self.tableView.backgroundView = (isEmpty) ? EmptyStateView(message: "Não há notificações",
        frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height)) : nil
        self.tableView.alwaysBounceVertical = !isEmpty
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
    func setupSiteAlert() {
        let requester =  AlertRequester(configuration: PucConfiguration.shared) { (alerts, silentLoginUrl, error) in
            DispatchQueue.main.async {
                guard let alerts = alerts else { return }
                let collectionView = SiteAlertCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 170))
                collectionView.siteAlerts = alerts
                collectionView.silentLoginURL = silentLoginUrl
                collectionView.delegate = self
                self.tableView.tableFooterView = collectionView
                self.tableView.reloadData()
                collectionView.alertCollectionView.reloadData()
            }
        }
        requester.start()
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
