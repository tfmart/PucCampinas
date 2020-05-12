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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: kAvaDetailTableViewCell)
        tableView.tableFooterView = UIView(frame: .zero)
        self.clearsSelectionOnViewWillAppear = true
        tableView.showLoading()
        fetchPages()
    }
    
    func fetchPages() {
        let requester = AvaSitePagesRequester(siteID: avaSite?.id ?? "", configuration: PucConfiguration.shared) { (sitePages, requestToken, error) in
            DispatchQueue.main.async {
                guard let sitePages = sitePages else {
                    self.tableView.setEmptyState(with: "Nenhum site foi encontrado para essa matéria")
                    return
                }
                DispatchQueue.main.async {
                    self.pages = []
                    for page in sitePages {
                        if page.shouldDisplay {
                            self.pages?.append(page)
                        }
                    }
                    self.tableView.reloadData()
                    self.tableView.hideLoading()
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: kAvaDetailTableViewCell, for: indexPath)
        if let page = pages?[indexPath.row] {
            cell.textLabel?.text = page.title
            cell.imageView?.image = pages?[indexPath.row].toolID?.image
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let toolID = pages?[indexPath.row].toolID else { return }
        switch toolID {
        case .resources:
            let fileTableView = AvaFilesViewController()
            fileTableView.title = pages?[indexPath.row].title
            fileTableView.siteURL = pages?[indexPath.row].resourceUrl
            self.navigationController?.pushViewController(fileTableView, animated: true)
        case .dropbox:
            let fileTableView = AvaFilesViewController()
            fileTableView.title = pages?[indexPath.row].title
            fileTableView.siteURL = pages?[indexPath.row].dropboxUrl
            fileTableView.isDropbox = true
            self.navigationController?.pushViewController(fileTableView, animated: true)
        case .announcements:
            let alertViewController = AvaAlertViewController()
            alertViewController.siteID = pages?[indexPath.row].siteID
            alertViewController.title = "Avisos"
            self.navigationController?.pushViewController(alertViewController, animated: true)
        default:
            let avaWebView = AvaWebViewController()
            avaWebView.url = pages?[indexPath.row].url
            avaWebView.url?.append("?sakai.session=\(token ?? "")")
            avaWebView.title = pages?[indexPath.row].title
            self.navigationController?.pushViewController(avaWebView, animated: true)
        }
    }
}

private extension AvaSitePage {
    var shouldDisplay: Bool {
        return (self.toolID != .iFrame && self.toolID != .sitestats)
    }
}

private extension SakaiTool {
    var image: UIImage? {
        switch self {
        case .site:
            return UIImage(systemName: "house")
        case .schedule:
            return UIImage(systemName: "calendar")
        case .assignmentGrades:
            return UIImage(systemName: "pencil")
        case .announcements:
            return UIImage(systemName: "bell")
        case .chat:
            return UIImage(systemName: "bubble.left")
        case .messages:
            return UIImage(systemName: "envelope")
        case .dropbox:
            return UIImage(systemName: "folder.badge.person.crop")
        case .samigo:
            return UIImage(systemName: "pencil.and.ellipsis.rectangle")
        case .forums:
            return UIImage(systemName: "bubble.left.and.bubble.right")
        case .melete:
            return UIImage(systemName: "book")
        case .syllabus:
            return UIImage(systemName: "doc.text")
        case .siteRoster:
            return UIImage(systemName: "person.2")
        case .gradebookTool:
            return UIImage(systemName: "list.number")
        case .resources:
            return UIImage(systemName: "tray.and.arrow.down")
        case .siteinfo:
            return UIImage(systemName: "info")
        case .iFrameService:
            return UIImage(systemName: "questionmark")
        default:
            return UIImage(systemName: "globe")
        }
    }
}
