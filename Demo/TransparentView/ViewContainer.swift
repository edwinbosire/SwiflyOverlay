//
//  ViewController.swift
//  TransparentView
//
//  Created by edwinbosire on 16/06/2016.
//  Copyright © 2016 Edwin Bosire. All rights reserved.
//

import UIKit

class ViewContainer: UIViewController, MenuViewDelegate {
    
    lazy var menuViewController: MenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("menu") as! MenuViewController
    @IBOutlet var viewContainer: UIView!
    var overlay: OverlayView?
    
    var signInViewController: UIViewController  {
        
        get {
            let viewController = UIViewController(nibName: nil, bundle: nil)
            viewController.view.backgroundColor = UIColor.init(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0)
            return viewController
        }
    }
    
    var infoViewController: UIViewController  {
        
        get {
            let viewController = UIViewController(nibName: nil, bundle: nil)
            viewController.view.backgroundColor = UIColor.init(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0)
            return viewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    }
    
    @IBAction func presentOverlay(sender: AnyObject) {
        
        menuViewController.delegate = self
        
        if overlay == nil {
            overlay = OverlayView()
        }
        
        overlay?.addSubview(menuViewController.view)
        overlay?.open()
    }
    
    /**
     Goes without saying, using literal types in switch statements is a bad idea, bad practices ensue in the example below,
        it's all to prove that our menu can be used in a versatile manner. 
     - Maybe lazy load the ViewControllers as well?
     - Remove views from container
     */
    
    func didSelect(menu: Menu, row: NSIndexPath, inTableView: UITableView) {
      
        self.title = menu.title;
        switch menu.title {
            
        case "Issues" :
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("viewController1")
            if let vc = viewController {
                displayContentController(vc)
            }
            break
            
        case "Daily Briefing":
            
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("viewController2")
            if let vc = viewController {
                displayContentController(vc)
//                removeContentController(currentChildView!)
            }
            break
            
        case "Bookmarks":
            
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("viewController3")
            if let vc = viewController {
                displayContentController(vc)
            }
            break
            
        case "Sign In":
            displayContentController(signInViewController)
            break
            
        case "Info":
            displayContentController(infoViewController)
            break
        default: break
            
        }
        overlay?.dismissView()
    }
    
    func displayContentController(content: UIViewController) {
        
        self.addChildViewController(content)
        content.view.frame = frameForContentController()
        self.view.addSubview(content.view)
        //TODO: Autolayout constraints go here
        content.didMoveToParentViewController(self)
    }
    
    func removeContentController(content: UIViewController) {
    
        content.willMoveToParentViewController(nil)
        //TODO: Remove any constraints that we configured withthe child's root view
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func frameForContentController() -> CGRect {
        return self.view.bounds
    }
}

