//
//  ViewController.swift
//  SwiftTask02
//
//  Created by ueda on 2018/09/14.
//  Copyright © 2018年 kohei.ueda. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var items: Results<Item>?
    
    @IBOutlet var tableView:UITableView!

    var backFromEditerVC : Bool = true {
        didSet {
            if backFromEditerVC {
                loadItems()
                print("load")
                print(items!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
    }
    
    // MARK: - Data Manupilation Methods
    func loadItems() {
        items = realm.objects(Item.self)
        
        tableView?.reloadData()
    }
    
    func delete(at indexPath: IndexPath) {
        if let itemForDeletion = items?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
        loadItems()
    }
    
    func getNewId() -> Int {
        var itemCount = realm.objects(Item.self).count
        itemCount += 1
        return itemCount
    }
    
    // MARK: -Add New Items
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
}

// MARK: - Table View Delegate, Datasource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        if let item = items?[indexPath.row]{
            
            let tv1 = cell.viewWithTag(1) as! UILabel
            tv1.text = item.title
            
            let tv2 = cell.viewWithTag(2) as! UILabel
            tv2.text = item.explanation
            
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditerViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedItem = items?[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive,
                                              title: "削除",
                                              handler: {(action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
                                                print(indexPath)
                                                self.delete(at: indexPath)
                                                success(true)
        })
        removeAction.image = UIImage(named: "trash")
        removeAction.backgroundColor = .red
    
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
}
