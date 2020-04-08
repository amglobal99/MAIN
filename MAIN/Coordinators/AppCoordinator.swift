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
    
    //var provider: ProviderType!
    //var session: SessionType = Session()
    
    //var vehicletoVehicleConnection: VehicletoVehicleConnectionType = globalEnableV2VR ?  VehicletoVehicleConnection() : MockVehicletoVehicleConnection()

    //var userLocationManager: UserLocationManagerType!

    weak var windowCoordinator: WindowCoordinator?
    
    var rootViewController: UIViewController {
        return rootBackgroundController
    }

    init(store: Store<AppState>, container: BackgroundContainerViewController) {
        self.store = store
        self.rootBackgroundController = container
    }

    //MARK:- START
    
    /// Called from the 'start() function in WindowCoordinartor.swift
    func start(route: Cordux.Route) {
        print("App Coordinator: start()")
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
        print("App Coordinator: changeScene() ...")
        
        //FIXME:- fix this
        
        guard let segment = RouteSegment(rawValue: route.first ?? "") else {
            print("App Coordinator: segment is nil. EXITING")
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


