//
//  ClothDetailViewController.swift
//  DressRoom
//
//  Created by daitran on 5/6/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit

class ClothDetailViewController: UIViewController {
    
    
    @IBOutlet weak var background: UIImageView!
    var cloth=UIImage(named: "item01_1")
    override func
        viewDidLoad() {
        super.viewDidLoad()
            background.image = cloth
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let aa = 0
    }

}
