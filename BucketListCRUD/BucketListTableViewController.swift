//
//  BucketListTableViewController.swift
//  BucketListCRUD
//
//  Created by Andy Feng on 2/13/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class BucketListTableViewController: UITableViewController, CancelButtonDelegate, AddItemDelegate, EditItemDelegate {

    // Global Variables :::::::::::::::::::::::::::::::::::::::::::
//    var items = ["Sky diving", "Live in Hawaii"]
    
    var items = [Item]()
    
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func getAllItems(){
        
        // Get stuff from CD
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.fetch(itemRequest)
            // downcast the results as an array of AwesomeEntity objects
            items = results as! [Item]
            // print the details of each item
            for item in items {
                print("\(String(describing: item.name))")
            }
            
            
            tableView.reloadData()
            
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        
        
    }
    
    
    
    // UI Lifecycle :::::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getAllItems()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // Table View Protocol Methods :::::::::::::::::::::::::::::::::
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = self.items[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "AddNewMission", sender: indexPath.row)
    }
    
    // Swipe for Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        self.items.remove(at: indexPath.row)
//        self.tableView.reloadData()
        
        
        // Remove the Item
        managedObjectContext.delete(items[indexPath.row])
        
        // Save and reload
        // Save to Core Data
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        
        /// Get all Items from Core Data and then reload TV
        getAllItems()

    }

    
    // Other Protocol Methods ::::::::::::::::::::::::::::::::::::::
    func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func addItem(item: String) {
        dismiss(animated: true, completion: nil)
//        self.items.append(item)
        
        // Create a new item
        let i = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedObjectContext) as! Item
        i.name = item
        
        
        
        // Save to Core Data
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        
        /// Get all Items from Core Data and then reload TV
        getAllItems()
    }
    
    func editItem(item: String, idx: Int) {
        dismiss(animated: true, completion: nil)
//        self.items[idx] = item
        
        // Edit the item
        items[idx].name = item
        
        // Save to Core Data
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        
        /// Get all Items from Core Data and then reload TV
        getAllItems()
        
        
        
    }
    
    // Segue :::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let send = sender {
            if send is Int {
                // Going to Edit things
                let navC = segue.destination as! UINavigationController
                let vc = navC.topViewController as! AddItemTableViewController
                vc.CancelButtonDelegate = self
                vc.addItemDelegate = self
                vc.editItemDelegate = self
                
                if let send = sender {
                    print(send)
                    vc.idxPath = send as? Int
                    vc.stringToEdit = self.items[vc.idxPath!].name
                }
                
            } else {
                // Add thing
                let navC = segue.destination as! UINavigationController
                let vc = navC.topViewController as! AddItemTableViewController
                vc.CancelButtonDelegate = self
                vc.addItemDelegate = self
                
            }
        }
        
    }

}

