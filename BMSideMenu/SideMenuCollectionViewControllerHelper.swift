//
//  SideMenuTableViewController.swift
//  BMSideMenu
//
//  Created by Byron Mackay on 10/7/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class SideMenuCollectionViewControllerHelper {
    
    func callItemSelectedOnMenu(vc:UIViewController) -> SideMenu? {
        let potentialSideMenu = vc.parentViewController
        if potentialSideMenu == nil {
            println("Error: Side Menu not found in view hierarchy")
            return nil
        }
        if potentialSideMenu is SideMenu {
            return potentialSideMenu as? SideMenu
        } else {
            callItemSelectedOnMenu(vc)
        }
        return nil
    }
    
}
