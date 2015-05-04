//
//  Helper.swift
//  DressRoom
//
//  Created by daitran on 5/4/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit

class Helper{
    class func scaledImageToSize(image: UIImage, newSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0 ,0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return newImage
    }
}