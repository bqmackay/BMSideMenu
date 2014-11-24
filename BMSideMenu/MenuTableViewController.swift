//
//  MenuTableViewController.swift
//  BMSideMenu
//
//  Created by Byron Mackay on 10/7/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    @IBOutlet weak var menuTable: UITableView!
    
    let menuHelper = SideMenuCollectionViewControllerHelper()
    
    var whichScreen = false
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        let parentViewController:SideMenu? = menuHelper.callItemSelectedOnMenu(self)
        if whichScreen == false {
            parentViewController?.itemSelected("My Contests")
        } else {
            parentViewController?.itemSelected("Contests")
        }
        whichScreen = !whichScreen

    }
    
}
