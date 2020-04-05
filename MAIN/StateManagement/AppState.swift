//
//  AppState.swift
//  MAIN
//
//  Created by amglobal on 4/4/20.
//  Copyright © 2020 Natsys. All rights reserved.
//



import Foundation
import Cordux
//import CBL

public enum RemoteServerAccessibilityStatus {
    case accessible
    case notAccessible
}



struct RouteSubscription {
    let route: Cordux.Route

    init(_ state: AppState) {
        route = state.route
    }
}



enum ConnectionState {
    case uninitialized
    case initialized(RemoteServerAccessibilityStatus)
}

enum ConnectionAction: Action {
    case updateConnectionStatus(RemoteServerAccessibilityStatus)
}


enum WindowAction: Action {
    case setKeyWindow(WindowKind)
    case setWindowVisible(WindowKind, Bool)
}

enum Initialization {
    case uninitialized
    case initialized(Authentication)
}

enum Authentication {
    case authenticated
    case unauthenticated
}

enum LoadingState<T> {
    case initialized
    case loading
    case loaded(T)
    case failure(Error)
}




struct WindowState {
    
    let keyWindow:  WindowKind
    let mainWindowVisible: Bool
    let v2vrWindowVisible: Bool
    let lunchWindowVisible: Bool
    
    init(keyWindow: WindowKind,
         mainWindowVisible: Bool = true,
         v2vrWindowVisible: Bool = false,
         lunchWindowVisible: Bool = false) {
        
        self.keyWindow = keyWindow
        self.mainWindowVisible = mainWindowVisible
        self.v2vrWindowVisible = v2vrWindowVisible
        self.lunchWindowVisible = lunchWindowVisible
    }
}





struct AppState: StateType {
    
    var route: Cordux.Route = [] {
        didSet {
            print("Current Route: \(route)")
        }
    }
    var initialization: Initialization = .uninitialized

    var windowState: WindowState
    var connectionState: ConnectionState
    
    init(route: Cordux.Route = [],
         initialization: Initialization = .uninitialized,
         windowState: WindowState,
         connectionState: ConnectionState) {
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
