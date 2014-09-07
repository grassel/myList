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
    
}
