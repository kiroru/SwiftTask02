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
    var delegate: EditorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldTitle.delegate = self
        textFieldExplanation.delegate = self
        
        textFieldTitle.text = selectedItem?.title
        textFieldExplanation.text = selectedItem?.explanation
    }
    
    // MARK: - Data Manupilation Methods
    
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
    
    func create() {
        _ = DBManager.sharedManager.create(title: textFieldTitle.text!, explanation: textFieldExplanation.text!)
    }
    
    func update() {
        if let selectedId = selectedItem?.id {
            _ = DBManager.sharedManager.update(id: selectedId,
                                               title: textFieldTitle.text!,
                                               explanation: textFieldExplanation.text!)
        }
    }
    
}

protocol EditorViewControllerDelegate {
    func itemChanged()
}
