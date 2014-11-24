//
//  SideMenu.swift
//  BMSideMenu
//
//  Created by Byron Mackay on 10/6/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class SideMenu: UIViewController {
    var delegate:SideMenuDelegate?
    let identifierDictionary:[String:String] = [
        "Contests":"MainNav",
        "My Contests":"SecondViewController",
        "Inbox":"Inbox",
        "User Profile":"UserProfile"
    ]
    
    func itemSelected(cellLabel:String) {
        delegate?.showViewController(identifierDictionary[cellLabel]!)
    }
    
}