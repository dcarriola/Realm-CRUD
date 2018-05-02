//
//  PickUpLinesTVC.swift
//  Realm-CRUD
//
//  Created by Daniel Alejandro Carriola on 5/1/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import UIKit
import RealmSwift

class PickUpLinesTVC: UITableViewController {

    // Variables
    var pickUpLines: Results<PickUpLine>!
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get data
        pickUpLines = RealmService.instance.read(objectType: PickUpLine.self)
//        print(RealmService.instance.realm.configuration.fileURL)
        
        // Reload data when a change happens
        notificationToken = RealmService.instance.realm.observe { (notification, realm) in
            self.tableView.reloadData()
        }
        
        // Handle errors
        RealmService.instance.observeRealmErrors(in: self) { (error) in
            print(error ?? "No error detected")
        }
    }
    
    // Remove observer
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationToken?.invalidate()
        RealmService.instance.stopObservingErrors(in: self)
    }

    // Add new pick up line
    @IBAction func onAdd(_ sender: Any) {
        AlertService.addAlert(in: self) { (line, score, email) in
            let newPickUpLine = PickUpLine(line: line, score: score, email: email)
            RealmService.instance.create(newPickUpLine)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickUpLines.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IDCell", for: indexPath) as? PickUpLineCell else { return UITableViewCell() }
        cell.configureCell(pickUpLine: pickUpLines[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pickUpLine = pickUpLines[indexPath.row]
        AlertService.updateAlert(in: self, pickUpLine: pickUpLine) { (line, score, email) in
            let dict: [String: Any?] = ["line": line, "score": score, "email": email]
            RealmService.instance.update(pickUpLine, with: dict)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        RealmService.instance.delete(pickUpLines[indexPath.row])
    }

}
