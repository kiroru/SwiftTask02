//
//  EditorViewController.swift
//  SwiftTask02
//
//  Created by sak on 2018/09/19.
//  Copyright © 2018年 kohei.ueda. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldExplanation: UITextField!
    
    var selectedItem : Item?
    var delegate: EditorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldTitle.delegate = self
        textFieldExplanation.delegate = self
        
        textFieldTitle.text = selectedItem?.title
        textFieldExplanation.text = selectedItem?.explanation
    }
    
    // MARK: - Data Manupilation Methods
    func create() {
        if let newItem = DBManager.sharedManager.create(title: textFieldTitle.text!,
                                                        explanation: textFieldExplanation.text!) {
            selectedItem = newItem
        }
    }
    
    func update() {
        _ = DBManager.sharedManager.update(item: selectedItem!,
                                           title: textFieldTitle.text!,
                                           explanation: textFieldExplanation.text!)
    }
    
    @IBAction func ok(sender: UIButton) {
        
        if selectedItem == nil {
            create()
        } else {
            update()
        }
        
        delegate?.itemChanged()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

protocol EditorDelegate {
    func itemChanged()
}
