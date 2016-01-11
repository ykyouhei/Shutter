//
//  GlobalFunctions.swift
//  Shutter
//
//  Created by kyo__hei on 2015/12/20.
//  Copyright © 2015年 Koganepj. All rights reserved.
//
//  

import Foundation
import XCGLogger
import UIKit

/// ログ用オブジェクト
public let log: XCGLogger = {
    let log = XCGLogger.defaultInstance()
    
    log.xcodeColorsEnabled = true
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: XCGLogger.XcodeColor(fg: UIColor.redColor(), bg: UIColor.whiteColor()), // Optionally use a UIColor
        .Severe: XCGLogger.XcodeColor(fg: (255, 255, 255), bg: (255, 0, 0)) // Optionally use RGB values directly
    ]
    
    #if DEBUG
        log.setup(.Debug,
            showThreadName: true,
            showLogLevel: true,
            showFileNames: true,
            showLineNumbers: true,
            writeToFile: nil)
    #else
        log.setup(.Severe,
            showThreadName: true,
            showLogLevel: true,
            showFileNames: true,
            showLineNumbers: true,
            writeToFile: nil)
    #endif
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy hh:mma"
    dateFormatter.locale = NSLocale.currentLocale()
    log.dateFormatter = dateFormatter
    
    return log
    
}()
