//
//  User.swift
//  Shutter
//
//  Created by kyo__hei on 2015/12/20.
//  Copyright © 2015年 Koganepj. All rights reserved.
//

import Parse

public final class User: PFUser {
    
    //========================================================================//
    // MARK: - Properties
    //========================================================================//
    
    dynamic public var name: String = ""
    
    dynamic public var iconFile: PFFile?
    
    
    
    //========================================================================//
    // MARK: - Override
    //========================================================================//
    
    override public class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }

}
