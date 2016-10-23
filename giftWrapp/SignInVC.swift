//
//  ViewController.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 24/09/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginBtnTapped(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("ERROR \(error)")
            } else if result?.isCancelled == true {
                print("User cancelled this shit. ")
                
            } else {
                print("Successfully authenticated FB.")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential:FIRAuthCredential) {
        
        
        FIRAuth.auth()?.signIn(with: credential, completion: {user, error in
            if error != nil {
                print(error)
                print("Unable to authenticate with Firebase")
                
            } else {
                print("Successfully authenticated with Firebase")
                if user != nil {
                    let userData = ["provider":user?.providerID,"email":user?.email,"profileImg":String(describing: user?.photoURL)]
                    DataService.ds.createFirebaseDBUser(uid: (user?.uid)!, userData:userData as! Dictionary<String, String>)
                KeychainWrapper.standard.set((user?.uid)!, forKey: KEY_UID)
                self.performSegue(withIdentifier: "goToFeed", sender: nil)
                
                }
            }
        })
    }


}
