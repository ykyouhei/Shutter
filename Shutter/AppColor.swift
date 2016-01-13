//
//  AppColor.swift
//  Shutter
//
//  Created by 山口　恭兵 on 2016/01/12.
//  Copyright © 2016年 Koganepj. All rights reserved.
//

import UIKit
import HEXColor

/**
 アプリ共通で利用する色を定義
 */
public struct AppColor {
    
    public static let navigationBarTint = UIColor(hex6: 0x242424)
    
    public struct Text {
        static let navigationTitle = UIColor(hex3: 0xFFF)
    }
    
}


extension AppColor {
    
    static func setupNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = navigationBarTint
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName : Text.navigationTitle
        ]
    }
    
}