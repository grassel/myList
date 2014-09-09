  //
//  ItemViewController.swift
//  myList
//
//  Created by Guido Grassel on 07/09/14.
//  Copyright (c) 2014 Guido Grassel. All rights reserved.
//

import UIKit
import CoreData
  
class ItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    
    // properties used to move data access from the ListTabletViewController
    var item : String = "";
    var quantity : String = ""
    var info : String = ""
    var existingItem : NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if existingItem != nil {
            itemNameTextField.text = item;
            quantityTextField.text = quantity
            infoTextField.text = info
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTabbed(sender: AnyObject) {
        
        // reference app delegate
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // referene managed object context
        let context : NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        
        // check if item exists
        if existingItem != nil {
            existingItem.setValue(itemNameTextField.text, forKey: "item");
            existingItem.setValue(quantityTextField.text, forKey: "quantity");
            existingItem.setValue(infoTextField.text, forKey: "info");
            
            println("existing item saved: \(existingItem)");
        } else {
            // create instance of pur data model and initialize
            var newItem = Model(entity: en!, insertIntoManagedObjectContext: context)
        
            // map properties
            newItem.item = itemNameTextField.text
            newItem.quantity = quantityTextField.text
            newItem.info = infoTextField.text

            println("new item saved: \(newItem)");
        }
        
        // save context
        context.save(nil) // no error handling
        
        
        // navigate back to root view controller
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        // navigate back to root view controller
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
