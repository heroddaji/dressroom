//
//  EditClothesViewController.swift
//  DressRoom
//
//  Created by daitran on 5/5/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit
import E84PopOutMenu

class EditClothesViewController: UIViewController{
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var slot1: UIButton!
    
    @IBOutlet weak var slot2: UIButton!
    
    @IBOutlet weak var slot3: UIButton!
    
    @IBOutlet weak var slot4: UIButton!
    
    
    @IBOutlet weak var slot5: UIButton!
    
    @IBOutlet weak var slot6: UIButton!
    
   
    @IBOutlet weak var stickerMenu: E84PopOutMenu!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uploadBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "uploadBtnClicked:")
        
        let actionBtnItems = [uploadBtn]
        self.navigationItem.rightBarButtonItems = actionBtnItems
        
        slot1.addGestureRecognizer(newSwipeGesture())
        slot2.addGestureRecognizer(newSwipeGesture())
        slot3.addGestureRecognizer(newSwipeGesture())
        slot4.addGestureRecognizer(newSwipeGesture())
        slot5.addGestureRecognizer(newSwipeGesture())
        slot6.addGestureRecognizer(newSwipeGesture())
        
        setupStickerMenu()
        
        background.image = UIImage(named: user.style.background)
    }
    
    func setupStickerMenu(){
        self.stickerMenu.interitemSpacing = 60.0;
        stickerMenu.menuDirection = E84PopOutMenuDirection.Down
        self.stickerMenu.addTarget(self, action: "stickerMenuChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        let menuItemBackgroundColor = self.view.backgroundColor;
        
        var sticker = UIButton(frame: stickerMenu.frame)
       // sticker.backgroundColor = UIColor.whiteColor()
        sticker.setTranslatesAutoresizingMaskIntoConstraints(false)
        var img = UIImage(named: "sticker")
        sticker.setImage(img, forState: UIControlState.Normal)
        
//        var img1 = Helper.compositeImage([UIImage(named: "sticker_box"), UIImage(named: "sticker1")],  size: stickerMenu.bounds.size)
//        var img2 = Helper.compositeImage([UIImage(named: "sticker_box"), UIImage(named: "sticker2")],  size: stickerMenu.bounds.size)
//        var img3 = Helper.compositeImage([UIImage(named: "sticker_box"), UIImage(named: "sticker3")],  size: stickerMenu.bounds.size)
        
        
        var sticker1 = UIButton(frame: stickerMenu.frame)
        sticker1.setTranslatesAutoresizingMaskIntoConstraints(false)
        var img1 = UIImage(named: "sticker1")
        sticker1.setImage(img1, forState: UIControlState.Normal)
        
        
        var sticker2 = UIButton(frame: stickerMenu.frame)
        sticker2.setTranslatesAutoresizingMaskIntoConstraints(false)
        var img2 = UIImage(named: "sticker2")
        sticker2.setImage(img2, forState: UIControlState.Normal)
        
        var sticker3 = UIButton(frame: stickerMenu.frame)
        sticker3.setTranslatesAutoresizingMaskIntoConstraints(false)
        var img3 = UIImage(named: "sticker3")
        sticker3.setImage(img3, forState: UIControlState.Normal)
        
        stickerMenu.addPopOutMenuItem(sticker, forIdentifier: "sticker")
        stickerMenu.addPopOutMenuItem(sticker1, forIdentifier: "sticker1")
        stickerMenu.addPopOutMenuItem(sticker2, forIdentifier: "sticker2")
        stickerMenu.addPopOutMenuItem(sticker3, forIdentifier: "sticker3")
    }
    
    func stickerMenuChanged(sender: AnyObject?){
        println(sender?.description)
        if let popoutMenu = sender as? E84PopOutMenu{
            let btn = popoutMenu.menuItemInfo["sticker1"] as! UIButton
            let data = NSKeyedArchiver.archivedDataWithRootObject(btn)
            var btn2:UIButton = NSKeyedUnarchiver .unarchiveObjectWithData(data) as! UIButton
            
    
            
            //btn2.setTitle("hello", forState: UIControlState.Normal)
//            btn2.frame = CGRectMake(100, 100, 50, 50)
//            btn2.setImage(btn.imageView?.image, forState: UIControlState.Normal)
//            btn2.backgroundColor = UIColor.whiteColor()
//            
//            self.view.addSubview(btn2)
        }
    }
    
    func newPanGesture() -> UIPanGestureRecognizer{
        let panGesture  = UIPanGestureRecognizer(target: self, action: "onBtnPan:")
        
        return panGesture
    }
    
    func onBtnPan(sender: UIPanGestureRecognizer){
//        switch sender.state{
//        //case .Ended:
//            
//        default: break
//        }
    }
    
    func newSwipeGesture() -> UISwipeGestureRecognizer {
        let swipeGesture  = UISwipeGestureRecognizer(target: self, action: "onClothBtnSwiped:")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right
        return swipeGesture
    }
    
    func uploadBtnClicked(sender: AnyObject){
        println(sender.description)
       
    }
    
    //MARK: cloth btn actions
    @IBAction func onClothBtnClicked(sender: UIButton) {
            }
    
    func onClothBtnSwiped(sender: UISwipeGestureRecognizer){
        println("change clothes")
        //display random clothes
        
        var r1 = arc4random_uniform(7)
        var r2 = arc4random_uniform(7)
        var name = "item0\(r1)_\(r2)"
       
        var img = UIImage(named: name)
        while img == nil{
            r1 = arc4random_uniform(7)
            r2 = arc4random_uniform(7)
            name = "item0\(r1)_\(r2)"
            img = UIImage(named: name)
        }
        println(sender.view?.description)
        
        if let btn = sender.view as? UIButton{
            user.style.clothes[btn.tag-1].img = name
            btn.setImage(img, forState: UIControlState.Normal)
        }
        
    }
}
