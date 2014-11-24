//
//  ViewController.swift
//  BMSideMenu
//
//  Created by Byron Mackay on 10/6/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class BaseViewControllerSideMenu: UIViewController {
    
    var viewControllerDelegate:ViewControllerWithSideBarDelegate?
    let tapGesture:UITapGestureRecognizer?
    let overlayView:UIView
    
    override init() {
        overlayView = UIView()
        super.init()
        tapGesture = UITapGestureRecognizer(target: self, action: "closeMenu:")
    }
    
    required init(coder aDecoder: NSCoder) {
        overlayView = UIView()
        super.init(coder: aDecoder)
        tapGesture = UITapGestureRecognizer(target: self, action: "closeMenu:")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if overlayView.frame.height == 0 || overlayView.frame.width == 0 {
            overlayView.frame = self.view.bounds
        }
        overlayView.addGestureRecognizer(tapGesture!)
    }

    @IBAction func menuButtonTapped(sender: AnyObject) {
        viewControllerDelegate?.menuButtonPressed()
        self.view.addSubview(overlayView)
    }

    func closeMenu(sender:AnyObject) {
        overlayView.removeFromSuperview()
        viewControllerDelegate?.closeMenu()
    }
}

