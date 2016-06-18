//
//  MenuTableViewCell.swift
//  TransparentView
//
//  Created by edwinbosire on 17/06/2016.
//  Copyright © 2016 Edwin Bosire. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    var menu: Menu {
        get {
            return self.menu
        }
        set {
            textLabel?.text = newValue.title
        }
    }
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.textColor = UIColor.darkGrayColor()
        textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        textLabel?.textAlignment = .Center
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            let titleWidth = textLabel?.intrinsicContentSize().width
            let separatorWidth:CGFloat = 240.0
            var ratio = (titleWidth! / separatorWidth)
            ratio += 0.2 * ratio // Add 20%
            
            UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { [unowned self] in
                self.separatorView.alpha = 1
                self.separatorView.transform = CGAffineTransformMakeScale(ratio, 1.0)

                }, completion: { finished in })
        }else {
            UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { [unowned self] in
                self.separatorView.alpha = 0
                self.separatorView.transform = CGAffineTransformMakeScale(0.2, 1.0)
                } , completion: { finished in })
        }
    }

}
