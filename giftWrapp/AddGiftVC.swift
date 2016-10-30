//
//  AddGiftVC.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 31/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import ChameleonFramework


class AddGiftVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.init(hexString: "#84C1FF")!,UIColor.init(hexString: "#FF7B45")!])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
