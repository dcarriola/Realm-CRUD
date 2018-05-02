//
//  PickUpLine.swift
//  Realm-CRUD
//
//  Created by Daniel Alejandro Carriola on 5/1/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PickUpLine: Object {
    // Variables
    dynamic var line: String = ""
    let score = RealmOptional<Int>()
    dynamic var email: String? = nil
    
    // Init
    convenience init(line: String, score: Int?, email: String?) {
        self.init()
        self.line = line
        self.score.value = score
        self.email = email
    }
    
    // Get string value from existing score
    func scoreString() -> String? {
        guard let score = score.value else { return nil }
        return String(score)
    }
}
