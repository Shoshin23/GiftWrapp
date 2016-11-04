//
//  DataServices.swift
//  giftWrapp
//
//  Created by Karthik Kannan on 22/10/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference() //save the DB reference. Build URLs based on that.
let STORAGE_BASE = FIRStorage.storage().reference() //save the Storage reference here.

class DataService {
    static let ds = DataService()
    
    private var _REF_DB = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE:FIRDatabaseReference {
        return _REF_DB
    }
    
    var REF_POSTS:FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS:FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_POST_IMAGES:FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData:Dictionary<String,String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
