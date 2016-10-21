//
//  MaterialButton.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 21/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit


class MaterialButton:UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:1.0, height:1.0)
        imageView?.contentMode = .scaleAspectFit
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        layer.cornerRadius = self.frame.width / 2
//        
//    }
    
}
