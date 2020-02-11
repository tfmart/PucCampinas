//
//  NotificationsTableViewController.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 22/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift
import SafariServices

class NotificationsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var notifications: [PucNotification]?
    let activityIndicator = UIActivityIndicatorView()
    var siteAlertCollectionView: SiteAlertCollectionView!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        siteAlertCollectionView = SiteAlertCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 123))
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

// MARK: - SiteAlertCollectionView Setup

extension NotificationsTableViewController {
    func getSiteAlerts() {
        let requester =  AlertRequester(configuration: PucConfiguration.shared) { (alerts, silentLoginUrl, error) in
            DispatchQueue.main.async {
                guard let alerts = alerts else {
                    self.setupStateView()
                    return
                }
                self.setupAlertCollectionView(with: alerts, silentLoginUrl: silentLoginUrl)
            }
        }
        showLoading()
        requester.start()
    }
    
    func setupAlertCollectionView(with alerts: [Alert]?, silentLoginUrl: String?) {
        siteAlertCollectionView.siteAlerts = alerts
        siteAlertCollectionView.silentLoginURL = silentLoginUrl
        siteAlertCollectionView.delegate = self
        self.tableView.tableFooterView = siteAlertCollectionView
        self.tableView.reloadData()
        self.tableView.backgroundView = nil
        siteAlertCollectionView.alertCollectionView.reloadData()
    }
    
    func setupStateView() {
        let isEmpty = self.notifications?.isEmpty ?? true
        self.tableView.reloadData()
        self.tableView.backgroundView = (isEmpty) ? EmptyStateView(message: "Não há notificações",
                                                                   frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width,
                                                                                 height: self.tableView.bounds.height)) : nil
        self.tableView.alwaysBounceVertical = !isEmpty
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

// MARK: - SelectedCellDelegate

extension NotificationsTableViewController: SelectedCellDelegate {
    func selectedItem(_ item: Any) {
        if let alertLink = item as? String, let alertURL = URL(string: alertLink) {
            let webView = SFSafariViewController(url: alertURL, configuration: SFSafariViewController.Configuration())
            present(webView, animated: true)
            
        }
    }
}
