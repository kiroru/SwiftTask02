//
//  DBManager.swift
//  SwiftTask02
//
//  Created by sak on 2018/09/19.
//  Copyright © 2018年 kohei.ueda. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager: NSObject {

    static let sharedManager = DBManager()
    let realm = try! Realm()

    private override init() {
        // Do nothing
    }
    
    func loadItems() -> [Item] {
        return realm.objects(Item.self).map {$0}
    }
    
    func delete(id: Int) -> Bool {
        do {
            try realm.write {
                let item = realm.objects(Item.self).filter("id = %@", id)
                realm.delete(item)
            }
        } catch {
            print("Error deleting category, \(error)")
            return false
        }
        return true
    }
    
    func create(title: String, explanation: String) -> Item? {
        let item = Item()
        item.id = newId()
        item.title = title
        item.explanation = explanation

        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error saving item \(error)")
            return nil
        }

        return item
    }
    
    func update(item: Item, title: String, explanation: String) -> Bool {
        do {
            try realm.write {
                item.title = title
                item.explanation = explanation
            }
        } catch {
            print("Error deleting category, \(error)")
            return false
        }
        
        return true
    }
    
    func count() -> Int {
        return realm.objects(Item.self).count
    }
    
    func newId() -> Int {
        if let item = realm.objects(Item.self).sorted(byKeyPath: "id").last {
            return item.id + 1
        } else {
            return 1
        }
    }
}
