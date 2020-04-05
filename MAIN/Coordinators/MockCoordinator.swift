//
//  MockCoordinator.swift
//  MAIN
//
//  Created by amglobal on 4/5/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux



//MARK:- Mock Coordinator

class MockCoordinator: AnyCoordinator {
    var route = Cordux.Route()
    var rootViewController: UIViewController = UIViewController()
    func start(route: Cordux.Route) {
        rootViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}


