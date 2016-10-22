//
//  PostCell.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 22/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import ChameleonFramework

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var giftDescription: UILabel!
    @IBOutlet weak var giftImg: UIImageView!
    
    
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

}
