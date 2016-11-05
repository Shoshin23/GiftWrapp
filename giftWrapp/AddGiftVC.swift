//
//  AddGiftVC.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 31/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import ChameleonFramework
import ImagePicker
import Spring
import Firebase

class AddGiftVC: UIViewController,ImagePickerDelegate,UITextFieldDelegate {

    @IBOutlet weak var questionsLabel: SpringLabel!
    
    @IBOutlet weak var selectedImageView: SpringImageView!
    @IBOutlet weak var giftDescription: UITextField!
    
    @IBOutlet weak var nextButton: SpringButton!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    
    var imageSelected:Bool!
    var giftOcassion:String!
    var giftDesc:String!
    
    func animateUIButton(_ uiElement:SpringButton,isHidden:Bool,animation:String,curve:String,duration:CGFloat) {
        uiElement.isHidden = isHidden
        uiElement.animation = animation
        uiElement.curve = curve
        uiElement.duration = duration
        uiElement.animate()
    }
    
    func animateUILabel(_ uiElement:SpringLabel,text:String,isHidden:Bool,animation:String,curve:String,duration:CGFloat) {
        uiElement.isHidden = isHidden
        uiElement.text = text
        uiElement.animation = animation
        uiElement.curve = curve
        uiElement.duration = duration
        uiElement.animate()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.init(hexString: "#84C1FF")!,UIColor.init(hexString: "#FF7B45")!])
        questionsLabel.text = "First, let's start with a photo..."
        delayWithSeconds(2) {
            let imagePicker = ImagePickerController()
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)

        }
        //hide all other UI elements except the label. show them later on taps.
        giftDescription.isHidden = true
        nextButton.isHidden = true
        // selectedImageView.isHidden = true
        giftDescription.delegate = self
        
        
    }
    

   
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delayWithSeconds(1) {
//       self.nextButton.isHidden = false
//        self.nextButton.animation = "easeIn"
//        self.nextButton.curve = "linear"
//        self.nextButton.duration = 2.0
//        self.nextButton.animate()
            
            self.animateUIButton(self.nextButton, isHidden: false, animation: "fadeIn", curve: "linear", duration: 2.0)
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: SpringButton) {
        //save occassion locally. 
        
        if questionsLabel.text! == "A brief description about the gift?" {
            self.giftDesc = giftDescription.text
            self.giftDescription.resignFirstResponder()
        
        guard let giftDesc = giftDescription.text , giftDesc != " " else {
            print("You need to enter a description")
            return
        }
        guard let img = selectedImageView.image, imageSelected == true else {
            print("An image must be selected.")
            return
        }
            self.giftDescription.text = " "

        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUID = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            DataService.ds.REF_POST_IMAGES.child(imgUID).put(imgData, metadata: metaData) {(metadata,error) in
                if error != nil {
                    print("Unable to upload an image.")
                    
                } else {
                    print("Successfully uploaded the image. ")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    self.postToFirebase(imgUrl: downloadURL!)
                    
                    
                }
            }
        }
        } else if questionsLabel.text! == "So, what's the occasion?" {
         
        
        giftOcassion = giftDescription.text
        giftDescription.text = " "
        
            self.delayWithSeconds(1) {
                self.animateUILabel(self.questionsLabel,text: "A brief description about the gift?", isHidden: false, animation: "slideRight", curve: "linear", duration: 1.2)
                self.giftDescription.resignFirstResponder()
                self.delayWithSeconds(2){
                    self.giftDescription.becomeFirstResponder()
            }
        }
        }

    }
    
    func postToFirebase(imgUrl:String) {
        //self.questionsLabel.text = "Your gift has been added."
        self.animateUILabel(self.questionsLabel, text: "Your gift has been added.", isHidden: false, animation: "slideRight", curve: "linear", duration: 1.2)
        
        let post :  Dictionary<String, AnyObject> = [
            "description" : giftDesc as AnyObject,
            "giftImg":imgUrl as AnyObject,
            "giftOcassion": giftOcassion as AnyObject,
            "likes": 0 as AnyObject
            
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        giftDescription.text! = " "
        imageSelected = false
        

        
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageSelected = false
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        imageSelected = true
        
        //show the next set of questions here. 
        
        //selectedImageView.isHidden = false
        giftDescription.isHidden = false
        questionsLabel.text = " "
        
        //animate the fucking elements. 
        delayWithSeconds(2) {
            self.animateUILabel(self.questionsLabel,text:"So, what's the occasion?", isHidden: false, animation: "slideRight", curve: "linear", duration: 1.2)
            self.delayWithSeconds(2){
            self.giftDescription.becomeFirstResponder() //shift focus to the textfield.
            }
        }
        
        delayWithSeconds(1) {
            self.selectedImageView.image = images.first
            self.selectedImageView.animation="fadeIn"
            self.selectedImageView.curve = "easeInOut"
            self.selectedImageView.duration = 2.3
            //self.selectedImageView.delay = 3.0
            self.selectedImageView.animate()
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
