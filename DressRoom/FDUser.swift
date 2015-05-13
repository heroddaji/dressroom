//
//  FDUser.swift
//  DressRoom
//
//  Created by daitran on 5/13/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import Foundation
import CoreData

class FDUser: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var height: NSNumber
    @NSManaged var age: NSNumber
    @NSManaged var gender: String

}
