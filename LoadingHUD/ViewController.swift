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
        show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show(){
        let subView = ReplicatorView(frame: CGRect(origin: CGPoint(x: view.center.x - 60, y: view.center.y - 60), size: CGSize(width: 120, height: 120)))
        subView.layer.cornerRadius = 10
        subView.backgroundColor = UIColor.lightGray
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: subView, selector: Selector(("animate")), userInfo: nil, repeats: true)
        view.addSubview(subView)
    }
}


