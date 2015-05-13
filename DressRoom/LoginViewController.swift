//
//  LoginViewController.swift
//  DressRoom
//
//  Created by daitran on 5/13/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit
import MaterialKit

class LoginViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    //MARK: IBACTION
     
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(managedObjectContext)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}
