//
//  User.swift
//  DressRoom
//
//  Created by daitran on 4/30/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import Foundation

class User: Printable  {
    var name = "user"
    var room = Room()
    
    init(name: String){
        self.name = name
    }
    
    var description: String{
        return "Name:\(name)"
    }

}
