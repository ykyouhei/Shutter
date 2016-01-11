//
//  ViewController.swift
//  Shutter
//
//  Created by kyo__hei on 2015/12/13.
//  Copyright © 2015年 Koganepj. All rights reserved.
//

import UIKit
import Result

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegueWithIdentifier(MainStoryboard.ViewControllerIdentifiers.showUploadViewController, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

