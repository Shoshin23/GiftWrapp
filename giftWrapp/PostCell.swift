//
//  PostCell.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 22/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var giftDescription: UILabel!
    @IBOutlet weak var giftImg: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post:Post!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let topColor = UIColor.init(hexString: "#4A4A4A")
//        let bottomColor = UIColor.init(hexString: "#2B2B2B")
//        self.contentView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.contentView.frame, andColors: [topColor!,bottomColor!])

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post:Post, img:UIImage?) {
        self.post = post
        self.giftDescription.text = post.description
        self.likesLbl.text = "\(post.likes)"
        self.giftImg.image = UIImage(named: post.giftImg)
        
        if img != nil {
            self.giftImg.image = img
        } else {
                let ref = FIRStorage.storage().reference(forURL: post.giftImg)
            ref.data(withMaxSize: 5 * 1024 * 1024, completion: { (data,error) in
                if error != nil {
                    print(error)
                    print("unable to donwload image from Firebase Storage.")
                    
                } else {
                    print("Image downloaded from Firebase Storage.")
                    
                    if data != nil {
                        if let img = UIImage(data: data!) {
                            self.giftImg.image = img
                            FeedVCViewController.imageCache.setObject(img, forKey: post.giftImg as NSString)
                            
                        }
                    }
                }
            })
            
        }
        
    }

}
