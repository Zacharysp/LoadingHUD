//
//  ReplicatorView.swift
//  LoadingHUD
//
//  Created by Dongjie Zhang on 3/8/17.
//  Copyright © 2017 Zachary. All rights reserved.
//

import Foundation
import UIKit

class itemLayer: CALayer {
    private let colors:[UIColor] = [
        hexColor(hex: "#FF007F"),
        hexColor(hex: "#FF0000"),
        hexColor(hex: "#FF7F00"),
        hexColor(hex: "#FFFF00"),
        hexColor(hex: "#7FFF00"),
        hexColor(hex: "#00FF00"),
        hexColor(hex: "#00FF7F"),
        hexColor(hex: "#00FFFF"),
        hexColor(hex: "#007FFF"),
        hexColor(hex: "#0000FF"),
        hexColor(hex: "#7F00FF"),
        hexColor(hex: "#FF00FF")
    ]
    var items = [CAShapeLayer]()
    
    override var frame: CGRect {
        didSet {
            buildLayers()
        }
    }
    
    private func buildLayers()
    {
        if self.sublayers != nil {
            self.sublayers?.removeAll()
            self.items.removeAll()
        }
        let angle = CGFloat(M_PI * 2.0) / CGFloat(colors.count)
        for index in 0...colors.count-1 {
            let layer = CAShapeLayer()
            layer.frame = self.bounds
            layer.backgroundColor = UIColor.clear.cgColor
            layer.strokeColor = colors[index].cgColor
            layer.lineWidth = 0
            layer.lineCap = kCALineCapRound
            let path = UIBezierPath()
            path.move(to: CGPoint(x: self.bounds.size.width / 2.0, y: 10))
            path.addLine(to: CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 4.0))
            layer.path = path.cgPath
            layer.transform = CATransform3DMakeRotation(CGFloat(index) * angle, 0.0, 0.0, 1.0)
            
            items.append(layer)
            self.addSublayer(layer)
        }
    }
}

class ReplicatorView: UIView {
    private var replicator : itemLayer!
    private var lastIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        replicator = itemLayer()
        replicator.frame = self.bounds
        self.layer.addSublayer(replicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate()
    {
        //add animation
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.duration = 2
        lineWidthAnimation.fromValue = 12
        lineWidthAnimation.toValue = 0
        lineWidthAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        //get index
        lastIndex = lastIndex + 1
        if lastIndex == replicator.items.count {
            lastIndex = 0
        }
        replicator.items[lastIndex].add(lineWidthAnimation, forKey: nil)
    }
}


fileprivate func hexColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

