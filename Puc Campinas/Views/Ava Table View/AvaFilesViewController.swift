//
//  AvaFilesViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 19/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import MobileCoreServices

class AvaFilesViewController: UIViewController {
    //MARK: - Properties
    
    var fileProvider: AvaFileProvider?
    var siteURL: String?
    private var filesTableView: UITableView!
    var isDropbox: Bool = false
    let refreshControl = UIRefreshControl()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFileProvider()
        if isDropbox {
            self.setupUploadButton()
        }
    }
    
    //MARK: - Setup methods
    
    fileprivate func setupTableView() {
        self.filesTableView = UITableView(frame: CGRect(x: 0,
                      y: 0,
                      width: self.view.frame.width,
                      height: self.view.frame.height),
        style: .plain)
        setupRefreshControl()
        filesTableView.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        filesTableView.tableFooterView = UIView(frame: .zero)
        filesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FileCell")
        filesTableView.delegate = self
        filesTableView.dataSource = self
        self.view.addSubview(filesTableView)
    }

    fileprivate func setupFileProvider() {
        guard let siteURL = self.siteURL, let serverURL = URL(string: siteURL) else { return }
        self.fileProvider = AvaFileProvider(webDavURL: serverURL)
        self.fetchFiles()
    }
    
    func setupRefreshControl() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        self.refreshControl.addTarget(self, action: #selector(fetchFiles), for: .valueChanged)
        filesTableView.refreshControl = self.refreshControl
    }
    
    fileprivate func setupUploadButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.doc.fill"), style: .plain, target: self, action: #selector(attachDocument))
    }
    
    fileprivate func setupTableViewState() {
        guard let filesTableView = self.filesTableView else { return }
        filesTableView.reloadData()
        filesTableView.backgroundView = (fileProvider?.files?.isEmpty ?? true) ? EmptyStateView(message: "Nenhum arquivo encontrado",
            frame: CGRect(x: 0, y: 0, width: filesTableView.bounds.width, height: filesTableView.bounds.height)) : nil
    }
    
    //MARK: - File Fetching Methods
    
    @objc fileprivate func fetchFiles() {
        self.filesTableView?.showLoading()
        fileProvider?.fetchFiles(success: {
            DispatchQueue.main.async {
                self.setupTableViewState()
                self.filesTableView.refreshControl?.endRefreshing()
            }
        }, failure: {
            self.filesTableView?.backgroundView = EmptyStateView(message: "Não foi possível carregar os arquivos",
                                                                 frame: CGRect(x: 0, y: 0,
                                                                               width: (self.filesTableView?.bounds.width)!,
                                                                               height: (self.filesTableView?.bounds.height)!))
            self.filesTableView.refreshControl?.endRefreshing()
        })
    }
}

//MARK: - UITableViewDelegate and DataSource

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

//MARK: - UIDocumentPickerDelegate

extension AvaFilesViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    @objc private func attachDocument() {
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        importMenu.allowsMultipleSelection = true
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        present(importMenu, animated: true)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for fileURL in urls {
            fileProvider?.webDavProvider?.copyItem(localFile: fileURL, to: "/\(fileURL.lastPathComponent)", completionHandler: { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.fetchFiles()
                    }
                }
            })
        }
    }

     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
