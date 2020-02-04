//
//  ClassDetailsUITableViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift
import MapKit

class ClassDetailsTableViewController: UITableViewController {
    
    var subject: Subject?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
//        tableView.alwaysBounceVertical = tableView.contentSize.height > tableView.frame.size.height
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        tableView.register(UINib(nibName: "ClassDetailViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")
        tableView.register(UINib(nibName: "LocationInfoCell", bundle: nil), forCellReuseIdentifier: "locationDetail")
        tableView.register(UINib(nibName: "ClassAttendanceCell", bundle: nil), forCellReuseIdentifier: "classAttendanceCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subject?.description != nil) ? 5 : 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? ClassDetailCell {
                cell.initalize(.courseInfo, firstDescription: (subject?.courseName?.formatTitle())!, secondDescription: (subject?.turn)!)
                return cell
            }
        }
        
        if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? ClassDetailCell {
                cell.initalize(.schedule, firstDescription: (subject?.time)!, secondDescription: (subject?.duration)!)
                return cell
            }
        }
        
        if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? ClassDetailCell {
                cell.initalize(.classroom, firstDescription: (subject?.professor?.formatTitle())!, secondDescription: (subject?.classroom)!)
                return cell
            }
        }
        
        if indexPath.row == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "locationDetail", for: indexPath) as? LocationInfoCell {
                if let building = subject?.building?.formatTitle(), subject?.classroom != nil,
                    let title = subject?.locationWithCampusString,
                    let latitude = subject?.latitude, let longitude = subject?.longitude,
                    let latitudeValue = Double(latitude), let longitudeValue = Double(longitude) {
                    cell.initialize(title: title, latitude: latitudeValue, longitude: longitudeValue, building: "Prédio \(building)")
                }
                
                return cell
            }
        }
        
        if indexPath.row == 4 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "classAttendanceCell", for: indexPath) as? ClassAttendanceTableViewCell {
                cell.initialize(percentage: subject?.attendance, attendedAmount: subject?.attendedClasses, totalAmount: subject?.amountClasses, lastUpdate: subject?.lastAttendanceUpdate)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    //Height for Row At
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ClassDetailsTableViewController: SelectedCellDelegate {
    func selectedItem(_ item: Any) {
        if let summary = item as? String {
            let summaryView = SummaryViewController()
            summaryView.summary = summary
            self.navigationController?.present(UINavigationController(rootViewController: summaryView), animated: true)
        }
        if let region = item as? MKCoordinateRegion {
            let mapViewController = ClassroomLocationViewController()
            mapViewController.region = region
            mapViewController.title = "Prédio \(subject?.building?.formatTitle() ?? "")"
            self.navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
}
