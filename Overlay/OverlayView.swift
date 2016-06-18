//
//  OverlayViewController.swift
//  TransparentView
//
//  Created by edwinbosire on 16/06/2016.
//  Copyright © 2016 Edwin Bosire. All rights reserved.
//

import UIKit

enum Style: Int {
    case Light, Dark
}

protocol OverlayViewDelegate {
    func didDismissView(view: OverlayView)
}

class OverlayView: UIView {
    
    var delegate: OverlayViewDelegate?
    var style: Style = .Light
    let statusBarStyle: UIStatusBarStyle = UIApplication.sharedApplication().statusBarStyle
    var closeButton: UIButton!
    let backgroundcolor = UIColor.clearColor()

    var presentationAnimation: CAAnimationGroup {
        get{
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.fromValue = 0.0
            fadeAnimation.toValue = 1.0
            fadeAnimation.duration = 0.3
            fadeAnimation.fillMode = kCAFillModeForwards
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.toValue = 1.0
            scaleAnimation.fromValue = 0.8
            scaleAnimation.duration = 0.3
            scaleAnimation.fillMode = kCAFillModeForwards
            
            let groupAnimation = CAAnimationGroup()
            groupAnimation.duration = 0.3
            groupAnimation.animations = [fadeAnimation, scaleAnimation]
            groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            return groupAnimation
        }
    }
    
    required init() {
        super.init(frame: CGRectZero)
        let frame = UIScreen.mainScreen().bounds
        self.frame = frame
        self.opaque = false
        self.backgroundColor = backgroundcolor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func open() {
        layer.removeAllAnimations()
        var window = UIApplication.sharedApplication().keyWindow
        
        if window == nil {
            window = UIApplication.sharedApplication().windows.first
        }
        
        if closeButton == nil {
            closeButton = UIButton(type: .System)
            closeButton.frame = CGRectMake(CGRectGetMaxX(self.frame) - 60, 30, 33, 33)
            let image = UIImage(named: "close-Icon")?.imageWithRenderingMode(.AlwaysTemplate)
            closeButton.setImage(image, forState: .Normal)
            closeButton.addTarget(self, action: #selector(dismissView), forControlEvents: .TouchDown)
        }
        
        self.addSubview(closeButton)
        
        /**
         HINT:
         To get the status bar to change color, dont forget to
         set UIViewControllerBasedStatusBarAppearance = No in info.plist
         */
        switch style {
        case .Dark:
            closeButton.tintColor = UIColor.whiteColor()
            UIApplication.sharedApplication().statusBarStyle = .LightContent
            break
        default:
            closeButton.tintColor = UIColor.darkGrayColor()
            UIApplication.sharedApplication().statusBarStyle = .Default
        }
        
        layer.addAnimation(presentationAnimation, forKey: "present")
        window?.subviews.first?.addSubview(self)
        
    }
    
    func dismissView() {
        
        UIView.animateWithDuration(0.3, animations: {
            self.transform = CGAffineTransformMakeScale(0.8, 0.8)
            self.alpha = 0.0
        }) { [unowned self]  (comlete) in
            self.removeFromSuperview()
            self.alpha = 1
            self.transform = CGAffineTransformIdentity
            UIApplication.sharedApplication().statusBarStyle = self.statusBarStyle
        }
        
        delegate?.didDismissView(self)
    }
    
}
