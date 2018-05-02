//
//  RealmService.swift
//  Realm-CRUD
//
//  Created by Daniel Alejandro Carriola on 5/1/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    // Singleton
    static let instance = RealmService()
    
    // Variables
    var realm = try! Realm()
    
    // Init
    private init() {}
    
    // Create
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            post(error)
        }
    }
    
    // Read
    func read<T: Object>(objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
    // Update
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    // Delete
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    // Post error
    func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    // Observer error
    func observeRealmErrors(in vc: UIViewController, _ completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    // Stop notification's observer
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
}
