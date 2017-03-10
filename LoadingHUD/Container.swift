//
//  Container.swift
//  LoadingHUD
//
//  Created by Dongjie Zhang on 3/9/17.
//  Copyright © 2017 Zachary. All rights reserved.
//

import UIKit

internal class ContainerView: UIView {
    
    internal var timer: Timer!
    internal let loadingView: ReplicatorView
    
    fileprivate let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.0, alpha:0.25)
        view.alpha = 0.0
        return view
    }()
    
    
    internal init(loadingView: ReplicatorView = ReplicatorView()) {
        self.loadingView = loadingView
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        loadingView = ReplicatorView()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.clear
        loadingView.frame.size = CGSize(width: 120, height: 120)
        loadingView.layer.cornerRadius = 10
        loadingView.backgroundColor = UIColor(white:1.0, alpha:0.75)
        loadingView.setup()
        addSubview(backgroundView)
        addSubview(loadingView)
    }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        loadingView.center = center
        backgroundView.frame = bounds
    }
    
    internal func showLoadingView() {
        layer.removeAllAnimations()
        loadingView.center = center
        loadingView.alpha = 1.0
        isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: loadingView, selector: Selector(("animate")), userInfo: nil, repeats: true)
    }

    //hide and remove loadingView with animation
    internal func hideLoadingView(animated anim: Bool, completion: ((Bool) -> Void)? = nil) {
        let finalize: (_ finished: Bool) -> (Void) = { finished in
            self.isHidden = true
            self.removeFromSuperview()
            self.timer.invalidate()
            completion?(finished)
        }
        
        if isHidden {
            return
        }
        
        if anim {
            UIView.animate(withDuration: 0.8, animations: {
                self.loadingView.alpha = 0.0
                self.hideBackground(animated: false)
            }, completion: { _ in finalize(true) })
        } else {
            self.loadingView.alpha = 0.0
            finalize(true)
        }
    }
    
    internal func showBackground(animated anim: Bool) {
        if anim {
            UIView.animate(withDuration: 0.175, animations: {
                self.backgroundView.alpha = 1.0
            })
        } else {
            backgroundView.alpha = 1.0
        }
    }
    
    internal func hideBackground(animated anim: Bool) {
        if anim {
            UIView.animate(withDuration: 0.65, animations: {
                self.backgroundView.alpha = 0.0
            })
        } else {
            backgroundView.alpha = 0.0
        }
    }
}
