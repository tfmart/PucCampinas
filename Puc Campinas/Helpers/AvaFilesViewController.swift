//
//  AvaFilesViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 19/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class AvaFilesViewController: UIViewController {
    var fileProvider: AvaFileProvider?
    var siteID: String?
    private var filesTableView: UITableView?

    fileprivate func setupFileProvider() {
        guard let siteID = self.siteID, let serverURL = URL(string: "http://ead.puc-campinas.edu.br/dav/\(siteID)") else { return }
        self.fileProvider = AvaFileProvider(webDavURL: serverURL)
        self.fetchFiles()
    }
    
    fileprivate func fetchFiles() {
        fileProvider?.fetchFiles(success: {
            DispatchQueue.main.async {
                self.setupTableViewState()
            }
        }, failure: {
            print("Failed to get files")
        })
    }
    
    fileprivate func setupTableViewState() {
        guard let filesTableView = self.filesTableView else { return }
        filesTableView.reloadData()
        filesTableView.backgroundView = (fileProvider?.files?.isEmpty ?? true) ? EmptyStateView(message: "Nenhum arquivo encontrado",
            frame: CGRect(x: 0, y: 0, width: filesTableView.bounds.width, height: filesTableView.bounds.height)) : nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filesTableView = UITableView(frame: CGRect(x: 0,
                      y: 0,
                      width: self.view.frame.width,
                      height: self.view.frame.height),
        style: .plain)
        guard let filesTableView = self.filesTableView else { return }
        filesTableView.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        filesTableView.tableFooterView = UIView(frame: .zero)
        filesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FileCell")
        filesTableView.delegate = self
        filesTableView.dataSource = self
        self.view.addSubview(filesTableView)
        setupFileProvider()
    }
}

extension AvaFilesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileProvider?.files?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)
        cell.textLabel?.text = fileProvider?.files?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent((fileProvider?.files?[indexPath.row].name)!)
        let filePath = fileURL.path
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: filePath) {
            fileProvider?.webDavProvider?.copyItem(path: fileProvider?.files?[indexPath.row].path ?? "/", toLocalURL: fileURL, completionHandler: { (error) in
                guard error == nil else { return }
                DispatchQueue.main.async {
                    let avaWebView = AvaWebViewController()
                    avaWebView.url = fileURL.absoluteString
                    avaWebView.title = self.fileProvider?.files?[indexPath.row].name
                    self.navigationController?.pushViewController(avaWebView, animated: true)
                }
            })
        } else {
            let avaWebView = AvaWebViewController()
            avaWebView.url = fileURL.absoluteString
            avaWebView.title = fileProvider?.files?[indexPath.row].name
            self.navigationController?.pushViewController(avaWebView, animated: true)
        }
    }
}
