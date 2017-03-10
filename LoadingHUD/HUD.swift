//
//  HUD.swift
//  LoadingHUD
//
//  Created by Dongjie Zhang on 3/9/17.
//  Copyright © 2017 Zachary. All rights reserved.
//

import UIKit

open class HUD: NSObject {
    
    fileprivate struct Constants {
        static let sharedHUD = HUD()
    }
    
    fileprivate let container = ContainerView()
    fileprivate var hideTimer: Timer?
    
    public typealias TimerAction = (Bool) -> Void
    fileprivate var timerActions = [String: TimerAction]()
    
    open class var sharedHUD: HUD {
        return Constants.sharedHUD
    }
    
    open var isVisible: Bool {
        return !container.isHidden
    }
    
    open func show(onView view: UIView? = nil) {
        let view: UIView = view ?? UIApplication.shared.keyWindow ?? UIApplication.shared.windows[0]
        if  !view.subviews.contains(container) {
            view.addSubview(container)
            container.frame.origin = CGPoint.zero
            container.frame.size = view.frame.size
            container.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
            container.isHidden = true
            container.isUserInteractionEnabled = false
        }
        container.showBackground(animated: true)
        showContent()
    }
    
    func showContent() {
        container.showLoadingView()
        hide(afterDelay: 5)
    }
    
    open func hide(animated anim: Bool = true, completion: TimerAction? = nil) {
        container.hideLoadingView(animated: anim, completion: completion)
    }
    
    open func hide(_ animated: Bool, completion: TimerAction? = nil) {
        hide(animated: animated, completion: completion)
    }
    
    open func hide(afterDelay delay: TimeInterval, completion: TimerAction? = nil) {
        let key = UUID().uuidString
        let userInfo = ["timerActionKey": key]
        if let completion = completion {
            timerActions[key] = completion
        }
        
        hideTimer?.invalidate()
        hideTimer = Timer.scheduledTimer(timeInterval: delay,
                                         target: self,
                                         selector: #selector(HUD.performDelayedHide(_:)),
                                         userInfo: userInfo,
                                         repeats: false)
    }
    
    internal func performDelayedHide(_ timer: Timer? = nil) {
        let userInfo = timer?.userInfo as? [String:AnyObject]
        let key = userInfo?["timerActionKey"] as? String
        var completion: TimerAction?
        
        if let key = key, let action = timerActions[key] {
            completion = action
            timerActions[key] = nil
        }
        
        hide(animated: true, completion: completion)
    }

}
