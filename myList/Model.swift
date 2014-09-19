//
//  Model.swift
//  myList
//
//  Created by Guido Grassel on 07/09/14.
//  Copyright (c) 2014 Guido Grassel. All rights reserved.
//

import UIKit
import CoreData

class Model: NSManagedObject {
    @NSManaged var item : String;
    @NSManaged var quantity : String;
    @NSManaged var info : String;
    
    /* see https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/BuildingCocoaApps/WritingSwiftClassesWithObjective-CBehavior.html
    section : Implementing Core Data Managed Object Subclasses
    
    Swift classes are namespaced—they’re scoped to the module (typically, the project) they are compiled in. To use a Swift subclass of the NSManagedObject class with your Core Data model, prefix the class name in the Class field in the model entity inspector with the name of your module.
    */
    
}
