//
//  LandingViewController.swift
//  DressRoom
//
//  Created by daitran on 5/13/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit
import MaterialKit

class LandingViewController: UIViewController {
    
    //MARK: IBAction and IBOutlet
    
    @IBAction func dressRoomBtnClicked(sender: MKButton) {
        var storyboard = UIStoryboard(name: StoryboardName.DressRoom.rawValue, bundle: nil)
        var viewController = storyboard.instantiateInitialViewController() as! UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    @IBAction func styleBtnClicked(sender: MKButton) {
    }
    
    

    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
