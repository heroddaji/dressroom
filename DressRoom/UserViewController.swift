//
//  UserViewController.swift
//  DressRoom
//
//  Created by daitran on 5/1/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit
import "3rdparylibs/ct_poput_menu/DressRoom-Bridging-Header.h"

class UserViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var users = [User]()
    var me = User(name: "me"){
        didSet{
            changeUserRoomBackground(UIImage(named: me.room.background))
        }
    }
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var clothSlot1: UIImageView!
    @IBOutlet weak var clothSlot2: UIImageView!
    @IBOutlet weak var clothSlot3: UIImageView!
    @IBOutlet weak var clothSlot4: UIImageView!
    @IBOutlet weak var clothSlot5: UIImageView!
    @IBOutlet weak var clothSlot6: UIImageView!

    @IBAction func conversationMenuBtnClicked(sender: UIButton) {
        let items = [1,2,3,4]
        popMenu = CTPopoutMenu
        
        popMenu = [[CTPopoutMenu alloc]initWithTitle:@"Title" message:@"message" items:items];
        popMenu.menuStyle = MenuStyleDefault , MenuStyleGrid , MenuStyleList or MenuStyleOval;//choose one from these
        [popMenu showMenuInParentViewController:parentVC withCenter:center];
        
    }
    
    @IBAction func settingMenuBtnClicked(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateSampleData()
        
        backgroundImage.tag = 999
        
        clothSlot1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
        clothSlot2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
        clothSlot3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
        clothSlot4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
        clothSlot5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
        clothSlot6.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
    }

    var countClothMenuBtnClick=0
    @IBAction func clothMenuBtnClicked(sender: UIButton) {
        
        let show = true
        revealClothSlot(showed:++countClothMenuBtnClick%2 == 1)
    }
    
    func revealClothSlot(showed show :Bool){
        clothSlot1.hidden = show
        clothSlot2.hidden = show
        clothSlot3.hidden = show
        clothSlot4.hidden = show
        clothSlot5.hidden = show
        clothSlot6.hidden = show
    }
    
    @IBAction func photoMenuBtnClicked(sender: UIButton) {
        var alert = UIAlertController(title: "Upload photo", message: "Choose photo source", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Library", style: UIAlertActionStyle.Default, handler:{
            action in switch action.style{
            case .Default:
                self.uploadPhotoFromDevice(UIImagePickerControllerSourceType.PhotoLibrary)
            default:break
            }
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler:{
            action in switch action.style{
            case .Default:
                self.uploadPhotoFromDevice(UIImagePickerControllerSourceType.Camera)
            default:break
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:{
            action in switch action.style{
            case .Cancel:
                break
            default:break
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
   
    var countTapClick=0
    
    @IBAction func opTapGesture(sender: UITapGestureRecognizer) {
        revealAllSubView(showed: ++countTapClick % 2 == 1)
    }
    
    func revealAllSubView(showed show:Bool){
//        for view in self.view.subviews as! [UIView] {
//            if view.tag != backgroundImage.tag {
//                 view.hidden = show
//            }
//        }
//        revealClothSlot(showed:countClothMenuBtnClick%2 == 1)
    }
    
    @IBAction func onSwipeGesture(sender: UISwipeGestureRecognizer) {
        me = nextUser()
    }
    
    var tindex = 0
    var tcycle = 7
    func onTapGestureFromClothSlot(gesture: UITapGestureRecognizer){
        
        if let clothSlot  = gesture.view as? UIImageView {
            if tindex++ > tcycle-1 {
                tindex = 1
            }
            clothSlot.image = UIImage(named: "cloth\(tindex)")
        }
        
    }
    
    func uploadPhotoFromDevice(srcType: UIImagePickerControllerSourceType){
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = srcType
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    var pickerImage = UIImage?()
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    
        let theInfo = info as NSDictionary
        let img = theInfo.objectForKey(UIImagePickerControllerOriginalImage) as! UIImage?
        pickerImage = img
        self.dismissViewControllerAnimated(true, completion: confirmEditUserRoomBackground)
    }
    
    func confirmEditUserRoomBackground(){
        var alert = UIAlertController(title: "Confirm", message: "Confirm changing photo?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:{
            action in switch action.style{
            case .Default:
                self.changeUserRoomBackground(self.pickerImage)
            default:break
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler:{
            action in switch action.style{
            case .Cancel:
                fallthrough
            default:break
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func changeUserRoomBackground(img:UIImage?){
        
        backgroundImage.image = img
    }
    
    var cycle = 4
    var index = 0
    func nextUser() -> User{
        if ++index > cycle-1 {
            index = 0
        }
        
        return users[index]
    }
    
  
    // sample data
    func generateSampleData(){
        
        for i in 1...cycle{
            var user = User(name:String(i))
            user.room.background = "background\(i)"
            users.append(user)
        }
      
        me =  users[1]
        println("generate some users \(users)")
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
