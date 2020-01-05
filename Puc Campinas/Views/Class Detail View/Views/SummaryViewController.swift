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
        setupTextView()
        self.view.addSubview(summaryTextView)
    }
    
    //MARK: - Methods
    
    func setupTextView() {
        guard let summary = summary, !summary.isEmpty else {
            summaryTextView.text = "Essa disciplina não possui ementa"
            return
        }
        summaryTextView.text = summary
    }
}
