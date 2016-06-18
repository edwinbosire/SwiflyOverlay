//
//  ViewController.swift
//  TransparentView
//
//  Created by edwinbosire on 16/06/2016.
//  Copyright © 2016 Edwin Bosire. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MenuViewDelegate {
    
    lazy var menuViewController: MenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("menu") as! MenuViewController
    var overlay: OverlayView?
    
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
    
    func didSelect(menu: Menu, row: NSIndexPath, inTableView: UITableView) {
        // Reload view based on menu
        self.title = menu.title;
        overlay?.dismissView()
    }
}

