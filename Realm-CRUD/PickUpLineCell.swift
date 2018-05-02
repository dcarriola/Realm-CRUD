//
//  PickUpLineCell.swift
//  Realm-CRUD
//
//  Created by Daniel Alejandro Carriola on 5/1/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import UIKit

class PickUpLineCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    
    // Set info from object to outlets
    func configureCell(pickUpLine: PickUpLine) {
        lineLbl.text = pickUpLine.line
        countLbl.text = pickUpLine.scoreString()
        emailLbl.text = pickUpLine.email
    }

}
