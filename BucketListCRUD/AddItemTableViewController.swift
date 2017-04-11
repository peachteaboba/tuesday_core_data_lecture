//
//  AddItemTableViewController.swift
//  BucketListCRUD
//
//  Created by Andy Feng on 2/13/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    // Global Variables
    var stringToEdit: String?
    var idxPath: Int?
    
    // Delegates
    weak var CancelButtonDelegate: CancelButtonDelegate?
    weak var addItemDelegate: AddItemDelegate?
    weak var editItemDelegate: EditItemDelegate?
    
    @IBOutlet weak var inputField: UITextField!
    @IBAction func handleCancelButtonPressed(_ sender: UIBarButtonItem) {
        CancelButtonDelegate?.cancelButtonPressed()
    }
    
    @IBAction func handleDoneButtonPressed(_ sender: UIBarButtonItem) {
        
        // Either add or edit
        if let input = self.inputField.text {
            if let editID = self.editItemDelegate {
                editID.editItem(item: input, idx: self.idxPath!)
            } else {
                self.addItemDelegate?.addItem(item: input)
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        // Auto fill the input if editing
        if let str = self.stringToEdit {
            self.inputField.text = str
        }
    }
    
    
    
    
    
}
