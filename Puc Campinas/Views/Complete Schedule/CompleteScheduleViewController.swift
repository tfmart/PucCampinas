//
//  CompleteScheduleViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 28/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class CompleteScheduleViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var weekdaysSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emptyClassView: UIView!
    
    //MARK: - Properties
    
    var completeSchedule: [Subject]?
    var todaySubjects: [Subject]?
    var footerView: UIView {
        let footer = UIView()
        footer.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        return footer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weekdaysSegmentedControl.addTarget(self, action: #selector(pressedSegmentedControl), for: .valueChanged)
        pressedSegmentedControl()
        self.scheduleTableView.tableFooterView = footerView
    }
    
    //MARK: - Methods
    
    func getDayForIndex() -> Int {
        let index = weekdaysSegmentedControl.selectedSegmentIndex
        return (index < 6) ? index + 2 : 1
    }
    
    @objc func pressedSegmentedControl() {
        todaySubjects = completeSchedule?.classes(forDay: getDayForIndex())
        scheduleTableView.isHidden = !(todaySubjects?.count ?? 0 > 0)
        emptyClassView.isHidden = todaySubjects?.count ?? 0 > 0
        scheduleTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension CompleteScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaySubjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCompleteScheduleCell, for: indexPath) as? CompleteScheduleTableViewCell else  {
            return UITableViewCell()
        }
        if let todaySubjects =  todaySubjects, todaySubjects.count > 0 {
            cell.textLabel?.text = todaySubjects[indexPath.row].name
        }
        return cell
    }
    
    
}
