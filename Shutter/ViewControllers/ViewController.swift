//
//  ViewController.swift
//  Shutter
//
//  Created by kyo__hei on 2015/12/13.
//  Copyright © 2015年 Koganepj. All rights reserved.
//

import UIKit
import Result

internal final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegueWithIdentifier(R.segue.viewController.homeToUploadViewController, sender: nil)
    }

}

