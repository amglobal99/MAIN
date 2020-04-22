//
//  MoreCoordinator.swift
//  MAIN
//
//  Created by amglobal on 4/8/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux
//import CBL

//MARK: - Coordinator Class

class MoreCoordinator: Coordinator {
    
    enum RouteSegment: String, RouteConvertible {
        case lunchOut
        case language
    }
    
    let store: Store<AppState>
    var route: Cordux.Route = []
    
   // var provider: ProviderType!
   // var moreViewController: MoreViewController!
    var presentedCoordinator: AnyCoordinator?
    var _navigationController: UINavigationController!
   // var lunchCoordinator: LunchCoordinator?
    
    var rootViewController: UIViewController {
        return _navigationController
    }

    
    
    /*
    var browsingState: BrowsingState {
      //  return store.state.browsingState
    }

    var checkInState: CheckInState<UnverifiedCheckinLoad> {
        return store.state.checkinState
    }

    var currentRoute: String {
        guard let route = browsingState.routeName else {
            fatalError("No current route in \(#file)")
        }
        return route
    }

    var currentDeliveryDay: DeliveryDayType {
        guard let currentDeliveryDay = browsingState.todaysDeliveryDay else {
            fatalError("No current delivery day in \(#file)")
        }
        return currentDeliveryDay
    }

    var currentUser: String {
        return browsingState.rsr.username
    }
    
 
 */
    
    
    
 
    //MARK: - User Preferences
    
//    var currentPreferences: [UserPreferenceKind] = []
    var displayMapEnabled: Bool = true
    var displayFeaturedNoteEnabled:  Bool = false
    
    //MARK: - Initializer
    
    init(store: Store<AppState>) {
        self.store = store
    }

    //MARK: - Start
    
    func start(route: Cordux.Route) {
        
        print("More: ***** START ******")
        
        
        let moreViewController = MoreViewController.build()
       // moreViewController.handler = self
        moreViewController.corduxContext = Context(route, lifecycleDelegate: self)
        
        _navigationController = UINavigationController(rootViewController: moreViewController)
        _navigationController.navigationBar.isTranslucent = false
    }
    
    //MARK: - Push View Controller
    
    func push(_ coordinator: AnyCoordinator, route: Cordux.Route = []) {
        self.presentedCoordinator = coordinator
        coordinator.start(route: route)
        _navigationController.pushViewController(coordinator.rootViewController, animated: true)
    }
}






//MARK: - View Lifecycle Delegate

extension MoreCoordinator: ViewControllerLifecycleDelegate {
    
    func viewWillAppear(_ viewController: UIViewController) {
       // store.subscribe(viewController)
    }
    
    func viewWillDisappear(_ viewController: UIViewController) {
        
      // store.unsubscribe(viewController)
        
    }
}

//MARK: - Handler for MoreViewController

