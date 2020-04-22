//
//  BackgroundContainerViewController.swift
//  MAIN
//
//  Created by amglobal on 4/5/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import UIKit

//MARK:- BackgroundContainerViewController

class BackgroundContainerViewController: UIViewController {
    
    var childViewController: UIViewController!
    
    enum Background {
        case color(UIColor)
        case view(UIView)
    }
    
    // MARK: - Initializers
    
    /// Function builds the background container view controller
    /// This function is called from the init() function in WindowCoordinator.swift
    class func build(withBackground background: Background = .color(.white), withChild childViewController: UIViewController) -> BackgroundContainerViewController {
        let storyboard = UIStoryboard(name: "BackgroundContainerViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BackgroundContainerViewController") as! BackgroundContainerViewController
       // vc.installBackground(background)
        // vc.replaceCurrentChildViewController(withViewController: childViewController)
        return vc
    }
    
    override var childForStatusBarStyle : UIViewController? {
        return childViewController
    }
    
    fileprivate func installBackground(_ background: Background) {
        
        view.backgroundColor = UIColor.yellow
        
        switch background {
        case .color(let color):
            view.backgroundColor = color
        case .view(let bgView):
            bgView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bgView)
           // bgView.constrainEdgeAnchorsToEdgeAnchors(of: view)
        }
    }

    
    // MARK: - Actions
    func replaceCurrentChildViewController(withViewController newChildViewController: UIViewController) {
        addChild(newChildViewController)
        
        guard childViewController != nil else {
            childViewController = newChildViewController
            childViewController.backgroundContainerViewController = self
            view.addSubview(childViewController.view)
            childViewController.didMove(toParent: self)
            return
        }
        
        transition(from: childViewController,
                                     to: newChildViewController,
                                     duration: 0.0,
                                     options: .transitionCrossDissolve,
                                     animations: nil) { completion in
                                        self.childViewController.willMove(toParent: nil)
                                        self.childViewController.removeFromParent()   //removeViewFromParent()
                                        self.childViewController = newChildViewController
                                        self.childViewController.backgroundContainerViewController = self
                                        self.childViewController.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
}//end class



//MARK:- Extension

extension UIViewController {
    
    fileprivate struct AssociatedKeys {
        static var backgroundContainerViewController: BackgroundContainerViewController?
    }
    
    var backgroundContainerViewController: BackgroundContainerViewController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.backgroundContainerViewController) as? BackgroundContainerViewController
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.backgroundContainerViewController,
                    newValue as BackgroundContainerViewController?,
                    .OBJC_ASSOCIATION_ASSIGN
                )
            }
        }
    }
}//end extension
