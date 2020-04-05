//
//  AppCoordinator.swift
//  MAIN
//
//  Created by amglobal on 4/5/20.
//  Copyright © 2020 Natsys. All rights reserved.
//


import UIKit
import Cordux
//import CBL

//typealias DatabaseManagerSetupCompletion = (_ provider: ProviderType)->()

final class AppCoordinator: SceneCoordinator, SubscriberType {
    
    var rootViewController: UIViewController = UIViewController()
    
    
    enum RouteSegment: String, RouteConvertible {
        case login
        case mainTabBar
        case debug
        case crashReporter
    }
    var scenePrefix: String = RouteSegment.login.rawValue

    let store: Store<AppState>
    //let rootBackgroundController: BackgroundContainerViewController

    var currentScene: AnyCoordinator?

    //var provider: ProviderType!
    //var session: SessionType = Session()
    
    //var vehicletoVehicleConnection: VehicletoVehicleConnectionType = globalEnableV2VR ?  VehicletoVehicleConnection() : MockVehicletoVehicleConnection()

    //var userLocationManager: UserLocationManagerType!

    weak var windowCoordinator: WindowCoordinator?
    
//    var rootViewController: UIViewController {
//        return UIViewController()
//    }

    init(store: Store<AppState>) {
        self.store = store
    }

    //MARK:- START
    
    func start(route: Cordux.Route) {
        store.subscribe(self, RouteSubscription.init)
        setupLocationManager()
        changeScene(route)
    }

    func newState(_ state: RouteSubscription) {
        self.route = state.route
    }

    func setupLocationManager() {
       // userLocationManager = UserLocationManager(store: store, rootViewController: rootViewController)
    }

    //MARK:- CHANGE SCENE
    
    func changeScene(_ route: Cordux.Route) {
        guard let segment = RouteSegment(rawValue: route.first ?? "") else {
            return
        }

        let coordinator: AnyCoordinator
        
        switch segment {
        case .login:
            print("AppCoordinator: this is login")
        case .mainTabBar:
           print("AppCoordinator: this is mainTAbBar")
          //  coordinator = MainTabCoordinator(store: store, provider: provider, session: session, v2vConnection: vehicletoVehicleConnection)
        case .debug:
            print("AppCoordinator: this isDebug")
        case .crashReporter:
            print("AppCoordinator: this is Crash")
        }

        scenePrefix = segment.rawValue

        
        coordinator = WindowCoordinator()
        coordinator.start(route: sceneRoute(route))
        currentScene = coordinator
       // rootBackgroundController.replaceCurrentChildViewController(withViewController: coordinator.rootViewController)
    }
}


