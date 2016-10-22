//
//  FeedVCViewController.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 22/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import ChameleonFramework

class FeedVCViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.init(hexString: "#000000")!,UIColor.init(hexString: "#686868")!])
        
        // methods for tableView init goes here.
        tableView.delegate = self
        tableView.dataSource = self
        

        
        setTableViewBackgroundGradient(sender: self.tableView,UIColor.init(hexString: "#84C1FF")!,UIColor.init(hexString: "#FF7B45")!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
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
