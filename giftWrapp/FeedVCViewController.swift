//
//  FeedVCViewController.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 22/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import SwiftKeychainWrapper

class FeedVCViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    static var imageCache: NSCache<NSString,UIImage> = NSCache()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //reload table. 
        print("this worked!")
      //  self.tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.init(hexString: "#000000")!,UIColor.init(hexString: "#686868")!])
        
        // methods for tableView init goes here.
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with:{ (snapshot) in
            self.posts = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP:\(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post =  Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        print(self.posts)
                    }
                }
            }
             self.tableView.reloadData()
        })
        

        
        setTableViewBackgroundGradient(sender: self.tableView,UIColor.init(hexString: "#84C1FF")!,UIColor.init(hexString: "#FF7B45")!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
       if  let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
        
        if let img = FeedVCViewController.imageCache.object(forKey: post.giftImg as NSString) {
            cell.configureCell(post: post,img:img)
            print("Posting \(cell.giftDescription)")
            return cell
        }
        else {
            cell.configureCell(post: post,img:nil)
            print("Posting \(cell.giftDescription)")
            return cell

        }
       }
       else {
        return PostCell()

        }
    }

     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTableViewBackgroundGradient(sender: UITableView, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = sender.bounds
        let backgroundView = UIView(frame: sender.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.backgroundView = backgroundView
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
