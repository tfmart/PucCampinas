//
//  AvaPagesTableViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 16/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class AvaPagesTableViewController: UITableViewController {
    
    var avaSite: AvaSite?
    var pages: [AvaSitePage]?
    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = avaSite?.title ?? ""
        fetchPages()
    }
    
    func fetchPages() {
        let requester = AvaSitePagesRequester(siteID: avaSite?.id ?? "", configuration: PucConfiguration.shared) { (sitePages, requestToken, error) in
            guard let sitePages = sitePages else {
                return
            }
            DispatchQueue.main.async {
                self.pages = sitePages
                self.tableView.reloadData()
            }
        }
        requester.start()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pages?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kAvaDetailTableViewCell, for: indexPath) as? AvaDetailsTableViewCell else {
            return UITableViewCell()
        }
        if let page = pages?[indexPath.row] {
            cell.siteTitleLabel?.text = page.title
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let avaWebView = AvaWebViewController()
        avaWebView.url = pages?[indexPath.row].url
        avaWebView.url?.append("?sakai.session=\(token ?? "")")
        self.navigationController?.pushViewController(avaWebView, animated: true)
    }
}
