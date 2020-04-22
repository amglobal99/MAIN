//
//  MainTabCoordinator.swift
//  MAIN
//
//  Created by amglobal on 4/8/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux
//import CBL


class MainTabCoordinator: NSObject, TabBarControllerCoordinator {
    
    let store: Store<AppState>
   // let provider: ProviderType
   // let session: SessionType
    var scenes: [Scene]
    let tabBarController: UITabBarController = UITabBarController()
    var isProductionEnv: Bool = true
    
    /// This initializer is called from the 'chnageScene' function in AppCoordinator.swift.
    init(store: Store<AppState>) {
        self.store = store
        scenes = [
           Scene(prefix: "more", coordinator: MoreCoordinator(store: store))
        ]
        super.init()
        self.store.subscribe(self) { state in return state }
    }

    //MARK:- ********** START ***************
    
    func start(route: Cordux.Route) {
        tabBarController.delegate = self
        tabBarController.tabBar.tintColor = Theme.Colors.tealishColor()
        tabBarController.tabBar.isTranslucent = false
        scenes.forEach { $0.coordinator.start(route: route) }
        tabBarController.viewControllers = scenes.map { $0.coordinator.rootViewController }
        store.setRoute(.push(scenes[tabBarController.selectedIndex]))
    }
}//end coordinator

//MARK:- ************** NEW STATE *******************

extension MainTabCoordinator: SubscriberType {
    
    func newState(_ state: AppState) {
       /// This will be executed any time an action is sent to store.
       /// update any variable value here if you need to
    }
}

//MARK:-  ******* Tab Controller Delegaet ************

extension MainTabCoordinator: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // If the user just selected the tab they're currently on
        // we want to avoid popping back to the root view controller
        if let rootViewController = currentScene?.rootViewController, rootViewController == viewController {
            return false
        }
        return setRouteForViewController(viewController)
    }
}
