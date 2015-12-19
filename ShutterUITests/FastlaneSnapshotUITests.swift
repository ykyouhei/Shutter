//
//  FastlaneSnapshotUITests.swift
//  Shutter
//
//  Created by kyo__hei on 2015/12/19.
//  Copyright © 2015年 Koganepj. All rights reserved.
//

import XCTest

/// fastlaneのスナップショット撮影用UIテスト
class FastlaneSnapshotUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        snapshot("snap0")
    }
    
}
