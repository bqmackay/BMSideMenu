//
//  SideMenuRootControllerCreator.swift
//  BMSideMenu
//
//  Created by Byron Mackay on 10/7/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class SideMenuRootControllerCreator {
    class func create() -> ViewControllerWithSideBar {
        let mainViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNav") as UIViewController
        let menuViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SideViewController") as UIViewController
        let container:ViewControllerWithSideBar = ViewControllerWithSideBar(nibName: nil, bundle: nil, mainViewController:mainViewController, menuViewController:menuViewController)
        
        return container
    }
}