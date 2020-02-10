//
//  SummaryViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 05/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    //MARK: - Properties
    
    var summary: String?
    let summaryTextView = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "Ementa"
        setupCloseButton()
        setupTextView()
        self.view.addSubview(summaryTextView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    //MARK: - Methods
    
    func setupTextView() {
        summaryTextView.font = .systemFont(ofSize: 16)
        guard let summary = summary, !summary.isEmpty else {
            summaryTextView.text = "Essa disciplina não possui ementa"
            return
        }
        summaryTextView.text = summary
    }
    
    func setupCloseButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Fechar", style: .done, target: self, action: #selector(close))
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
