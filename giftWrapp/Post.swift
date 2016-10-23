//
//  Gift.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 23/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import Foundation

class Post {
    private var _description:String!
    private var _giftImg: String!
    private var _likes: Int!
    private var _postKey: String!
    
    var description:String {
        return _description
    }
    
    var giftImg:String {
        return _giftImg
    }
    
    var likes:Int {
        return _likes
    }
    
    var postKey:String {
        return _postKey
    }
    
    init(description:String, giftImg:String, likes:Int) {
        self._description = description
        self._giftImg = giftImg
        self._likes = likes
    }
    
    init(postKey:String,postData:Dictionary<String,AnyObject>) {
        self._postKey = postKey
        
        if let description = postData["description"] as? String {
            self._description = description
        }
        
        if let giftImg = postData["giftImg"] as? String {
            self._giftImg = giftImg
        }
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
    }
}
