//
//  ViewControllerLifecycle.swift
//  CorduxPrototype
//
//  Created by Ian Terrell on 7/22/16.
//  Copyright © 2016 WillowTree. All rights reserved.
//

import UIKit

@objc public protocol ViewControllerLifecycleDelegate {
    @objc optional func viewDidLoad(viewController: UIViewController)
    @objc optional func didMove(toParentViewController: UIViewController?, viewController: UIViewController)
}

extension UIViewController {
    static let swizzle: Void = {
        UIViewController.cordux_swizzleMethod(#selector(UIViewController.viewDidLoad),
                                              swizzled: #selector(UIViewController.cordux_viewDidLoad))

        UIViewController.cordux_swizzleMethod(#selector(UIViewController.didMove),
                                                  swizzled: #selector(UIViewController.cordux_didMoveToParentViewController(_:)))
    }()

    public class func swizzleLifecycleDelegatingViewControllerMethods() {
        _ = swizzle
    }

    @objc func cordux_viewDidLoad() {
        self.cordux_viewDidLoad()
            self.corduxContext?.lifecycleDelegate?.viewDidLoad?(viewController: self)
    }

    @objc func cordux_didMoveToParentViewController(_ parentViewController: UIViewController?) {
        self.cordux_didMoveToParentViewController(parentViewController)
        self.corduxContext?.lifecycleDelegate?.didMove?(toParentViewController: parentViewController, viewController: self)
    }

    static func cordux_swizzleMethod(_ original: Selector, swizzled: Selector) {
        let originalMethod = class_getInstanceMethod(self, original)
        let swizzledMethod = class_getInstanceMethod(self, swizzled)

        let didAddMethod = class_addMethod(self, original, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))

        if didAddMethod {
            class_replaceMethod(self, swizzled, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
