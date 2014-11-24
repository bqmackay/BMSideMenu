//
//  ViewControllerWithSideBar.swift
//  BMSideMenu
//
//  Created by Byron Mackay on 10/6/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class ViewControllerWithSideBar: UIViewController, ViewControllerWithSideBarDelegate, SideMenuDelegate {
    
    let mainView:UIView
    let sideMenuViewController:SideMenu
    var menuMainConstraint:NSLayoutConstraint?
    var mainViewController:UIViewController?
    var otherConstraint:NSLayoutConstraint?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, mainViewController:UIViewController, menuViewController:UIViewController) {
        self.sideMenuViewController = SideMenu()
        mainView = UIView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        addMenuToViewController(menuViewController)
        addViewControllerToMainContainer(mainViewController)
        addMainContainer()
    }
    
    func addMainContainer() {
        view.addSubview(mainView)
        mainView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addConstraint(NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        
        menuMainConstraint = NSLayoutConstraint(item: sideMenuViewController.view, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.mainView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(menuMainConstraint!)
    }
    
    func addViewControllerToMainContainer(parentViewController:UIViewController) {
        mainViewController?.view.removeFromSuperview()
        mainViewController = nil
        
        self.mainView.addSubview(parentViewController.view)
        
        getBaseSideMenuViewController(parentViewController)?.viewControllerDelegate = self
        
        UIView.performWithoutAnimation({
            parentViewController.view.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.mainView.addConstraint(NSLayoutConstraint(item: parentViewController.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.mainView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
            self.mainView.addConstraint(NSLayoutConstraint(item: parentViewController.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.mainView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
            self.mainView.addConstraint(NSLayoutConstraint(item: parentViewController.view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.mainView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
            self.otherConstraint = NSLayoutConstraint(item: parentViewController.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.mainView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
            self.mainView.addConstraint(self.otherConstraint!)
            parentViewController.view.layoutIfNeeded()
        })
        
        mainViewController = parentViewController
        
    }
    
    func getBaseSideMenuViewController(viewController:UIViewController) -> BaseViewControllerSideMenu? {
        if viewController.isKindOfClass(BaseViewControllerSideMenu) {
            return viewController as? BaseViewControllerSideMenu
        }
        if viewController.isKindOfClass(UINavigationController) {
            return (viewController as UINavigationController).viewControllers[0] as? BaseViewControllerSideMenu
        }
        return nil
    }
    
    func addMenuToViewController(menuVC: UIViewController) {
        view.addSubview(sideMenuViewController.view)
        self.sideMenuViewController.view.addSubview(menuVC.view)
        self.sideMenuViewController.addChildViewController(menuVC)
        self.sideMenuViewController.delegate = self
        sideMenuViewController.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addConstraint(NSLayoutConstraint(item: sideMenuViewController.view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.5, constant: 40))
        self.view.addConstraint(NSLayoutConstraint(item: sideMenuViewController.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: sideMenuViewController.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: UIApplication.sharedApplication().statusBarFrame.height))
    }

    required init(coder aDecoder: NSCoder) {
        self.sideMenuViewController = SideMenu()
        mainView = UIView()
        super.init(coder:aDecoder)
    }
    
    func menuButtonPressed() {
        menuMainConstraint?.constant = 200
        otherConstraint?.constant = 200
        buildShadow()
        UIView.animateWithDuration(0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func closeMenu() {
        menuMainConstraint?.constant = 0
        otherConstraint?.constant = 0
        UIView.animateWithDuration(0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func buildShadow() {
        
        if let view = mainViewController?.view {
            var pathRect:CGRect = view.bounds
            pathRect.size = view.frame.size
            mainViewController?.view.layer.shadowPath = UIBezierPath(rect: pathRect).CGPath
        }
        
        mainViewController?.view.layer.shadowOpacity = 0.75
        mainViewController?.view.layer.shadowRadius = 10.0
        mainViewController?.view.layer.shadowColor = UIColor.blackColor().CGColor
        mainViewController?.view.layer.rasterizationScale = UIScreen.mainScreen().scale
        
    }
    
    func showViewController(identifier: String) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(identifier) as UIViewController
        addViewControllerToMainContainer(viewController)
        closeMenu()
    }
}

protocol ViewControllerWithSideBarDelegate {
    func menuButtonPressed()
    func closeMenu()
}

protocol SideMenuDelegate {
    func showViewController(identifier:String)
}