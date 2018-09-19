//
//  EditerViewController.swift
//  RealmSample
//
//  Created by ueda on 2018/08/31.
//  Copyright © 2018年 kohei.ueda. All rights reserved.
//

import UIKit
import RealmSwift

class EditerViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldExplanation: UITextField!
    
    var selectedItem : Item? {
        didSet {
            setItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldTitle.delegate = self
        textFieldExplanation.delegate = self
        
        textFieldTitle.text = selectedItem?.title
        textFieldExplanation.text = selectedItem?.explanation
    }
    
    func setItem() {
        
    }
    
    // MARK: - Data Manupilation Methods
    func create() {
        let newItem = Item()
        newItem.id = self.getNewId()
        newItem.title = textFieldTitle.text!
        newItem.explanation = textFieldExplanation.text!
        print(newItem)
        do {
            try realm.write {
                realm.add(newItem)
            }
            selectedItem = newItem
        } catch {
            print("Error saving item \(error)")
        }
    }
    
    func update() {
        do {
            try realm.write {
                selectedItem?.title = textFieldTitle.text!
                selectedItem?.explanation = textFieldExplanation.text!
            }
        } catch {
            print("Error deleting category, \(error)")
        }
    }
    
    func getNewId() -> Int {
        var itemCount = realm.objects(Item.self).count
        itemCount += 1
        return itemCount
    }
    


    @IBAction func ok(sender: UIButton) {

        if selectedItem == nil {
                        create()
                    } else {
                        update()
                    }
        if self.presentingViewController is ViewController {
            let controller = self.presentingViewController as! ViewController
            controller.backFromEditerVC = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
