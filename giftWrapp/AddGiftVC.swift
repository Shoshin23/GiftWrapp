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

class AddGiftVC: UIViewController,ImagePickerDelegate,UITextFieldDelegate {

    @IBOutlet weak var questionsLabel: SpringLabel!
    
    @IBOutlet weak var selectedImageView: SpringImageView!
    @IBOutlet weak var giftDescription: UITextField!
    
    @IBOutlet weak var nextButton: SpringButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.init(hexString: "#84C1FF")!,UIColor.init(hexString: "#FF7B45")!])
        questionsLabel.text = "So, let's start with a photo..."
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
        nextButton.isHidden = false
        nextButton.animation = "fadeIn"
        nextButton.curve = "linear"
        nextButton.duration = 1.0
        nextButton.animate()
    }
    
    
    @IBAction func nextButtonTapped(_ sender: SpringButton) {
//        questionsLabel.animation = "slideRight"
//        questionsLabel.curve = "linear"
//        questionsLabel.duration = 1.2
//        questionsLabel.animate()
    }
    
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        //show the next set of questions here. 
        
        //selectedImageView.isHidden = false
        giftDescription.isHidden = false
        questionsLabel.text = " "
        
        //animate the fucking elements. 
        delayWithSeconds(2) {
            self.questionsLabel.text = "So, what's the occasion?"
            self.questionsLabel.animation = "slideRight"
            self.questionsLabel.curve = "linear"
            self.questionsLabel.duration = 1.2
            self.questionsLabel.animate()
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
