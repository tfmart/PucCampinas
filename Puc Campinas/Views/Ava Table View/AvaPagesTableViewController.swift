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
        self.navigationItem.title = avaSite?.title?.formatAvaTitle() ?? ""
        tableView.tableFooterView = UIView(frame: .zero)
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kAvaDetailTableViewCell, for: indexPath) as? AvaDetailsTableViewCell else {
            return UITableViewCell()
        }
        if let page = pages?[indexPath.row] {
            cell.siteTitleLabel?.text = page.title
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch pages?[indexPath.row].tools?[0].toolID {
        case "sakai.resources":
            let fileTableView = AvaFilesViewController()
            fileTableView.title = pages?[indexPath.row].title
            fileTableView.siteURL = pages?[indexPath.row].resourceUrl
            self.navigationController?.pushViewController(fileTableView, animated: true)
        case "sakai.dropbox":
            let fileTableView = AvaFilesViewController()
            fileTableView.title = pages?[indexPath.row].title
            fileTableView.siteURL = pages?[indexPath.row].dropboxUrl
            fileTableView.isDropbox = true
            self.navigationController?.pushViewController(fileTableView, animated: true)
        default:
            let avaWebView = AvaWebViewController()
            avaWebView.url = pages?[indexPath.row].url
            avaWebView.url?.append("?sakai.session=\(token ?? "")")
            avaWebView.title = pages?[indexPath.row].title
            self.navigationController?.pushViewController(avaWebView, animated: true)
        }
    }
}
