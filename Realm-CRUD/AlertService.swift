//
//  AlertService.swift
//  Realm-CRUD
//
//  Created by Daniel Alejandro Carriola on 5/1/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import UIKit

class AlertService {
    // Private init
    private init() {}
    
    // Create alert with 3 textfields and return their text
    static func addAlert(in vc: UIViewController, _ completion: @escaping (String, Int?, String?) -> Void) {
        let alert = UIAlertController(title: "Add Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTxt) in
            lineTxt.placeholder = "Enter Pick Up Line"
            lineTxt.autocapitalizationType = .sentences
        }
        alert.addTextField { (scoreTxt) in
            scoreTxt.placeholder = "Enter Score"
            scoreTxt.keyboardType = .numberPad
        }
        alert.addTextField { (emailTxt) in
            emailTxt.placeholder = "Enter E-Mail"
            emailTxt.keyboardType = .emailAddress
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                  let scoreString = alert.textFields?[1].text,
                  let emailString = alert.textFields?.last?.text
                  else { return }
            
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
            completion(line, score, email)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    // Create alert to update each value
    static func updateAlert(in vc: UIViewController, pickUpLine: PickUpLine, _ completion: @escaping (String, Int?, String?) -> Void) {
        let alert = UIAlertController(title: "Add Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTxt) in
            lineTxt.placeholder = "Enter Pick Up Line"
            lineTxt.autocapitalizationType = .sentences
            lineTxt.text = pickUpLine.line
        }
        alert.addTextField { (scoreTxt) in
            scoreTxt.placeholder = "Enter Score"
            scoreTxt.keyboardType = .numberPad
            scoreTxt.text = pickUpLine.scoreString()
        }
        alert.addTextField { (emailTxt) in
            emailTxt.placeholder = "Enter E-Mail"
            emailTxt.keyboardType = .emailAddress
            emailTxt.text = pickUpLine.email
        }
        
        let action = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                  let scoreString = alert.textFields?[1].text,
                  let emailString = alert.textFields?.last?.text
                  else { return }
            
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
            completion(line, score, email)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
