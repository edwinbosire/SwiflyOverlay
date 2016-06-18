//
//  MenuViewController.swift
//  TransparentView
//
//  Created by edwinbosire on 17/06/2016.
//  Copyright © 2016 Edwin Bosire. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
    func didSelect(menu: Menu, row: NSIndexPath, inTableView: UITableView)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: MenuViewDelegate?
    var menu: [Menu] {
        get {
            return [Menu(), Menu(title:"Issues"), Menu(title:"Daily Briefing"), Menu(title:"Bookmarks"), Menu(title:"Sign In"), Menu(title:"Info")]
        }
    }
    
    let cellIdentifier = "cellIdentifier"
    lazy var checkMark  = UIImageView(image: UIImage(named: "check"))
    var selected: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView () {
        tableView.reloadData()
        if tableView.indexPathsForVisibleRows?.count > 0 {
            tableView.selectRowAtIndexPath(tableView!.indexPathsForVisibleRows![selected], animated: true, scrollPosition: .None)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MenuTableViewCell
        cell.menu = menu[indexPath.row]        
        if indexPath.row == 0 {
            // we could create a whole new 'spacer' cell. but I am lazy, so I wont.
            cell.userInteractionEnabled = false
        }
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected = indexPath.row
        
        if let delegate = delegate {
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.4 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { [unowned self] in
                delegate.didSelect(self.menu[indexPath.row], row:indexPath, inTableView: tableView)
            }

        }
    }
}
