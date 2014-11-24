//
//  ViewController.swift
//  BMSideMenu
//
//  Created by Byron Mackay on 10/6/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewControllerDelegate:ViewControllerWithSideBarDelegate?
    var tapGesture:UITapGestureRecognizer?

    @IBAction func menuButtonTapped(sender: AnyObject) {
        viewControllerDelegate?.menuButtonPressed()
        tapGesture = UITapGestureRecognizer(target: self, action: "closeMenu:")
        self.view.addGestureRecognizer(tapGesture!)
    }

    func closeMenu(sender:AnyObject) {
        viewControllerDelegate?.closeMenu()
        self.view.removeGestureRecognizer(tapGesture!)
    }
}

