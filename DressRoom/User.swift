//
//  User.swift
//  DressRoom
//
//  Created by daitran on 4/30/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import Foundation

class User {
    class Style {
        class Sticker{
            var pos = CGPoint()
            var img = "sticker1"
        }
        class Cloth{
            var img = "cloth1"
        }
        
        class Chat{
            var conversation = ["profile1":"hello, I like your style"]
        }
        
        var stickers = [Sticker]()
        var clothes = [Cloth](count: 6, repeatedValue: Cloth())
        var chat = Chat()
        var background = "style1"
    }
    
    
    
    var profile = "profile1"
    var style = Style()
    
}
