//
//  ViewController.swift
//  LoadingHUD
//
//  Created by Dongjie Zhang on 3/8/17.
//  Copyright © 2017 Zachary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        HUD.sharedHUD.show()
    }
}


