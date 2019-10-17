//
//  ViewController.swift
//  SwiftTask02
//
//  Created by ueda on 2018/09/14.
//  Copyright © 2018年 kohei.ueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    var items: [Item]?
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadItems()
    }
    
    // MARK: - Data Manupilation Methods
    func loadItems() {
        items = DBManager.sharedManager.loadItems()
        tableView.reloadData()
    }
    
    func delete(at indexPath: IndexPath) {
        let item = items![indexPath.row]
        _ = DBManager.sharedManager.delete(id: item.id)
        loadItems()
    }
    
    // MARK: - Add New Items
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditorViewController
        destinationVC.delegate = self
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedItem = items?[indexPath.row]
        }
    }
    
}

// MARK: - EditorDelegate
extension ViewController: EditorDelegate {
    
    func itemChanged() {
        loadItems()
    }
    
}

// MARK: - Table View Delegate, Datasource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // セルをスワイプしたら削除
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
