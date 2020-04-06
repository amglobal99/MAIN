//
//  AppState.swift
//  MAIN
//
//  Created by amglobal on 4/4/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux

//MARK:- Enums

public enum RemoteServerAccessibilityStatus {
    case accessible
    case notAccessible
}

enum ConnectionStateKind {
    case uninitialized
    case initialized(RemoteServerAccessibilityStatus)
}

enum ConnectionActionKind: Action {
    case updateConnectionStatus(RemoteServerAccessibilityStatus)
}

enum WindowAction: Action {
    case setKeyWindow(WindowKind)
    case setWindowVisible(WindowKind, Bool)
}

enum InitializationKind {
    case uninitialized
    case initialized(AuthenticationKind)
}

enum AuthenticationKind {
    case authenticated
    case unauthenticated
}

enum LoadingState<T> {
    case initialized
    case loading
    case loaded(T)
    case failure(Error)
}


//MARK:- Route Subscription

struct RouteSubscription {
    let route: Cordux.Route

    init(_ state: AppState) {
        route = state.route
    }
}


//MARK:- ********* APP STATE **************

/// THis is the struct that hold info about app State.
/// Note: The AppState contains 4 elements
/// - Route
/// - InitializationKind
/// - WindowState
/// - ConnectionState

struct AppState: StateType {
    
    var route: Cordux.Route = [] {
        didSet {
            print("Current Route: \(route)")
        }
    }
    var initialization: InitializationKind = .uninitialized
    var windowState: WindowState
    var connectionState: ConnectionStateKind
    
    /// This initializer is called from following locations:
    /// 1. init() function in WindowCoordinator.swift
    /// 2.  handleAction() function in AppReducer.swift
    init(route: Cordux.Route = [],
         initialization: InitializationKind = .uninitialized,
         windowState: WindowState,
         connectionState: ConnectionStateKind) {
        self.route = route
        self.initialization = initialization
        self.windowState = windowState
        self.connectionState = connectionState
    }
}



/*
extension AppState {
    var isInBrowsingState: Bool {
        guard case .authenticated(_) = authenticationState else {
            return false
        }
        return true
    }
    var browsingState: BrowsingState {
        get {
            guard case let .authenticated(browsingState) = authenticationState else {
                // JE: we're getting this error regularly in prod. adding more details
                fatalError("We're not in a state where browsingState is available.  route=\(route) authenticationState=\(authenticationState)")
            }
            return browsingState
        }
    }

    var authenticationState: Authentication {
        get {
            guard case let .initialized(authentication) = initialization else {
                fatalError("initialization=\(initialization) instead of .initialized")
            }
            return authentication
        }
    }

    var checkinState: CheckInState<UnverifiedCheckinLoad> {
        guard let checkinState = browsingState.checkinState else {
            fatalError("CheckinState was nil in \(#file) \(#function)")
        }
        return checkinState
    }

    var safeBrowsingState: BrowsingState? {
        guard case let .initialized(.authenticated(browsingState)) = initialization else {
            return nil
        }
        return browsingState
    }
    
    var vehicleToVehicleReplenishmentState: VehicleToVehicleReplenishmentState? {
        switch self.browsingState.vehicleToVehicleReplenishmentState{
        case .loaded(let state):
            return state
        default:
            return nil
        }
    }
}

 

 */
