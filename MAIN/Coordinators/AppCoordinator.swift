//
//  AppCoordinator.swift
//  MAIN
//
//  Created by amglobal on 4/5/20.
//  Copyright © 2020 Natsys. All rights reserved.
//


import UIKit
import Cordux

//MARK:- *********** COORDINATOR *************

final class AppCoordinator: SceneCoordinator, SubscriberType {
    
    enum RouteSegment: String, RouteConvertible {
        case login
        case mainTabBar
        case debug
        case crashReporter
    }
    var scenePrefix: String = RouteSegment.login.rawValue
    let store: Store<AppState>
    var currentScene: AnyCoordinator?
    let rootBackgroundController: BackgroundContainerViewController
    weak var windowCoordinator: WindowCoordinator?
    
    var rootViewController: UIViewController {
        return rootBackgroundController
    }
    
    /// Called from init() function in WindowCoordinator.swift
    init(store: Store<AppState>, container: BackgroundContainerViewController) {
        self.store = store
        self.rootBackgroundController = container
    }

    //MARK:- ******* START *******
    
    /// Called from the 'start()' function in WindowCoordinartor.swift
    ///
    func start(route: Cordux.Route) {
        print("App Coordinator: start()  .... route: \(route)")
        store.subscribe(self, RouteSubscription.init)
        //setupLocationManager()
        changeScene(route)
    }

    //MARK:-
    
    //MARK:- ****** NEW STATE ********
    
    func newState(_ state: RouteSubscription) {
        self.route = state.route
    }

    //MARK:-
    
//    func setupLocationManager() {
//       // userLocationManager = UserLocationManager(store: store, rootViewController: rootViewController)
//    }

    
    
    
    //FIXME:- THIS NEEDS TO BE FIXED
    
    
    //MARK:- CHANGE SCENE
    
    /// Function called from the 'start()' function in AppCoordinator.swift
    func changeScene(_ route: Cordux.Route) {
            print("App Coordinator: changeScene() ... segment: \(String(describing: RouteSegment(rawValue: route.first ?? "")))")
            guard let segment = RouteSegment(rawValue: route.first ?? "") else {
                print("App Coordinator: segment is nil. EXITING")
                return
            }

            var coordinator: AnyCoordinator
        
            switch segment {
            case .login:
                print("AppCoordinator: this is login")
                coordinator = MoreCoordinator(store: store)
            case .mainTabBar:
                print("AppCoordinator: this is mainTAbBar")
                coordinator = MainTabCoordinator(store: store)
            case .debug:
                print("AppCoordinator: this isDebug")
                coordinator = MoreCoordinator(store: store)
            case .crashReporter:
                print("AppCoordinator: this is Crash")
                coordinator = MoreCoordinator(store: store)
            }
            
            scenePrefix = segment.rawValue
            coordinator.start(route: sceneRoute(route))
            currentScene = coordinator
            rootBackgroundController.replaceCurrentChildViewController(withViewController: coordinator.rootViewController)
        }
    
    
}//end class


