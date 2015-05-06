//
//  UserViewController.swift
//  DressRoom
//
//  Created by daitran on 5/1/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit


class UserViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AKPickerViewDataSource, AKPickerViewDelegate {
    
    var users = [User]()
    var me = User(){
        didSet{
            changeUserRoomBackground(UIImage(named: me.style.background))
        }
    }
    
    let profileCount = 7
    let backgroundCount = 7
    let clothCount = 12
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var clothSlot1: UIImageView!
    @IBOutlet weak var clothSlot2: UIImageView!
    @IBOutlet weak var clothSlot3: UIImageView!
    @IBOutlet weak var clothSlot4: UIImageView!
    @IBOutlet weak var clothSlot5: UIImageView!
    @IBOutlet weak var clothSlot6: UIImageView!
    @IBOutlet weak var conversationMenuBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    
    var pickerView = AKPickerView()
    
    
    var profiles = [String]()
    var profileClickCount = 0
    @IBAction func profileBtnClicked(sender: UIButton) {
        pickerView.hidden = ++profileClickCount % 2 == 0
    }
    
    func showProfiles(){
        
    }
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return profiles.count
    }
    
    func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        let image = Helper.scaledImageToSize(UIImage(named: profiles[item])!, newSize: CGSizeMake(45, 45))
        
        return image
    }
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        println(item)
        me = users[item]
        me.style.background = "style\(item+1)"
        backgroundImage.image = UIImage(named: "style\(item+1)")
    }
    
    @IBAction func conversationMenuBtnClicked(sender: UIButton) {
        var conversations = [KxMenuItem]()
        for i in 1...4{
            let image = Helper.scaledImageToSize(UIImage(named: "profile\(i)")!, newSize: CGSizeMake(40, 40))
            let menuItem = KxMenuItem("Hello, I like your style", image: image , target: self, action: "showConversation:")
            conversations.append(menuItem)
        }
        
        KxMenu.showMenuInView(self.view, fromRect: sender.frame, menuItems: conversations)
        
    }
    
    func showConversation(sender: AnyObject){
        if let knMenuItem = sender as? KxMenuItem{
            let conversationView = self.storyboard?.instantiateViewControllerWithIdentifier("conversationView") as! ConversationTableViewController
            self.navigationController?.pushViewController(conversationView, animated: true)
        }
        
    }
    
    
    @IBAction func settingMenuBtnClicked(sender: UIButton) {
        
        var settings = [KxMenuItem]()
        let menuItem = KxMenuItem("Log out", image: Helper.scaledImageToSize(UIImage(named: "logout")!, newSize: CGSizeMake(45, 45)), target: self, action: nil)
        settings.append(menuItem)
        KxMenu.showMenuInView(self.view, fromRect: sender.frame, menuItems: settings)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateSampleData()
        
        backgroundImage.tag = 999
        
//        clothSlot1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
//        clothSlot2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
//        clothSlot3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
//        clothSlot4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
//        clothSlot5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
//        clothSlot6.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapGestureFromClothSlot:"))
        
        //generate profile wheel
        for i in 1...profileCount{
            profiles.append("profile\(i)")
        }
        
        pickerView =  AKPickerView(frame: CGRectMake(profileBtn.frame.origin.x + profileBtn.frame.width, profileBtn.frame.origin.y, 200, profileBtn.frame.height))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.pickerViewStyle = .Wheel
        pickerView.reloadData()
        pickerView.hidden = true
        pickerView.tag = 998
        self.view.addSubview(pickerView)

    }

    var countClothMenuBtnClick=0
    @IBAction func clothMenuBtnClicked(sender: UIButton) {
        
       //edit style
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
//            if view.tag == pickerView.tag{
//                if pickerView.hidden == false{
//                    pickerView.hidden = true
//                    profileClickCount = 0
//                }
//            }
//        }
    }
    
    @IBAction func onSwipeGesture(sender: UISwipeGestureRecognizer) {
       // me = nextUser()
    }
    
    var tindex = 0
    func onTapGestureFromClothSlot(gesture: UITapGestureRecognizer){
        
        if let clothSlot  = gesture.view as? UIImageView {
            if tindex++ == clothCount {
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
    
    
    var index = 0
    func nextUser() -> User{
        if ++index == backgroundCount {
            index = 0
        }
        
        return users[index]
    }
    
    
  
    // sample data
    func generateSampleData(){
        
        for i in 1...backgroundCount{
            var user = User()
            user.profile = "profile\(i)"
            user.style.background = "style\(i)"
            users.append(user)
        }
      
        me =  users[0]
        println("generate some users \(users)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editClothViewController"{
            let viewController:EditClothesViewController = segue.destinationViewController as! EditClothesViewController
            viewController.user = me
        }
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
