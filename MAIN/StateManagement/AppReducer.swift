//
//  AppReducer.swift
//  MAIN
//
//  Created by amglobal on 4/4/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux

//public enum ActionLoggingLevel {
//    case none
//    case actionName
//    case actionDetails
//}

//MARK: - Protocol

//public protocol ActionLogPrintable {
//    var logLevel: ActionLoggingLevel { get }
//}

//MARK: - Action

extension Action {
    var shortName: String {
        let str = "\(self)"
        if let idx = str.firstIndex(where: { $0 == "(" }) {
            return String(str[..<idx])
        } else {
            return str
        }
    }
}






//MARK: - ****** App Reducer *****

struct AppReducer: Reducer {

    /// This function is called every time an action is sent to store.
    /// The reducer will give us a new App State. We need to run 4 reducers to get new values for each component.
    /// REMEMBER: App State is made up of 4 components:
    /// 1. InitializationKind
    /// 2. Route
    /// 3. Window State
    /// 4. Connection State
    func handleAction(_ action: Action, state: AppState) -> AppState {
        print("Handling action: \(type(of:action)).\(action.shortName)")
        
        /// get new InitializationKind and Route
        let (intialization, route) = initializationReducer(action, state: state.initialization, route: state.route)
        
        /// get new Window State
        let windowState = windowsReducer(action, state: state.windowState)
        
        /// get new Connection State
        let connectionState = connectionReducer(action, state: state.connectionState)
        
        return AppState(route: route,
                        initialization: intialization,
                        windowState: windowState,
                        connectionState: connectionState)
    }
}






//MARK:-  ***** Initialization Reducer *****


/// This function calls other reducers based on the action.
func initializationReducer(_ action: Action, state: InitializationKind, route: Cordux.Route) -> (InitializationKind, Cordux.Route) {
    switch (action, state) {
        //    case let (action as InitialDownloadAction, _):
        //        return initialDownloadActionReducer(action, state: state, route: route)
        //    case let (action as LoginAction, .initialized(.unauthenticated(loginState))):
        //        return (.initialized(.unauthenticated(loginActionReducer(action, state: loginState))), route)
        //        case let (action as AuthenticationAction, _):
        //        return authenticationActionReducer(action, state: state, route: route)
        //
        //        case let (action as EmailStateAction, state):
        //        if case let .initialized(.authenticated(browsingState)) = state {
        //            return browsingStateActionReducer(action, state: browsingState, route: route)
        //        }
        //        fatalError("Accessing browsing state when we shouldn't")
        //
        
        
    default:
        return (state, route)
    }
    return (state, route)
}



/*
 
 
 func initializationReducer(_ action: Action, state: Initialization, route: Cordux.Route) -> (Initialization, Cordux.Route) {
     switch (action, state) {
     case let (action as InitialDownloadAction, _):
         return initialDownloadActionReducer(action, state: state, route: route)
     case let (action as LoginAction, .initialized(.unauthenticated(loginState))):
         return (.initialized(.unauthenticated(loginActionReducer(action, state: loginState))), route)
     case let (action as AuthenticationAction, _):
         return authenticationActionReducer(action, state: state, route: route)
     case let (action as DeliveriesAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return deliveriesActionReducer(action, state: browsingState, route: route)
         }
         fatalError("")
     case let (action as CheckoutVehicleAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as CheckInActionWrapper, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as VehicleReplenishmentAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as DeliveryDetailStopAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as CustomerDetailStateAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as PrinterStateAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as EmailStateAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as FilterDeliveriesStateAction, state):
       if case let .initialized(.authenticated(browsingState)) = state {
         return browsingStateActionReducer(action, state: browsingState, route: route)
       }
     case let (action as UserPreferencesStateAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")
     case let (action as CopiedTicketAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
     case let (action as MyVehicleAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
     case let (action as VehicleToVehicleReplenishmentAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
     case let (action as VehicleToVehicleReplenishmentLoadedAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
     case let (action as LunchAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
     case let (action as ReorderAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }

     case let (action as RequestLoadStateAction, state):
         if case let .initialized(.authenticated(browsingState)) = state {
             return browsingStateActionReducer(action, state: browsingState, route: route)
         }
         fatalError("Accessing browsing state when we shouldn't")

     default:
         return (state, route)
     }
     return (state, route)
 }

 
 
 
 
 */






//MARK: - ***** Windows Reducer *****

func windowsReducer(_ action: Action, state: WindowState) -> WindowState {
    
    guard let windowAction = action as? WindowAction else {
        return state
    }
    
    switch windowAction {
    case .setKeyWindow(let kind):
        return WindowState(keyWindow: kind,
                           mainWindowVisible: state.mainWindowVisible)
    case .setWindowVisible(let kind, let visible):
        switch kind {
        case .main:
            return WindowState(keyWindow: state.keyWindow,
                               mainWindowVisible: visible)
        }
    }
}



//MARK: - ***** Connection Reducer *****

func connectionReducer(_ action: Action, state: ConnectionStateKind) -> ConnectionStateKind {
    guard let connectionAction = action as? ConnectionActionKind,
        case let .updateConnectionStatus(newStatus) = connectionAction else {
        return state
    }
    
    return .initialized(newStatus)
}




/*
//MARK: - Authentication Action Reducer

func authenticationActionReducer(_ action: AuthenticationAction, state: Initialization, route: Cordux.Route) -> (Initialization, Cordux.Route) {
    switch action {
    case let .signIn(user: rsr, currentUserPreferencesState: currentUserPreferencesState, currentRoute: currentRoute):
            globalLogger?.debug("\(#function) - BEFORE:  Display Map \(currentUserPreferencesState.displayMapEnabled) Display Featured Note: \(currentUserPreferencesState.displayFeaturedLocationNoteEnabled   )")
            
            let browsingState = BrowsingState(rsr: rsr, routeName: currentRoute?.number,
                                              vehicleNumber: nil, shouldUpdateDeliveriesList: false,
                                              currentDeliveryDay: nil, deliveryDays: [], deliveryStops: [], deliveryDetailState: [:],
                                              checkoutState: nil, checkinState: nil, requestLoadState: nil, customerDetailState: [:], closeReasons: [],
                                              rescheduleReasons: [], freeItemReasons: [], returnItemReasons: [], returnEquipmentReasons: [],
                                              holdReasons: [], serviceRequestResolutionReasons: [], availableLanguages: [], currentDeliveryItem: nil, printerState: PrinterState(), emailState: EmailState(), filterDeliveriesState: FilterDeliveriesState(),
                                              userPreferencesState: currentUserPreferencesState, vehicleReplenishmentState: .initialized,
                                              vehicleState: .initialized, vehicleToVehicleReplenishmentState: .initialized, lunchState: LunchState(), reorderState: ReorderState(), otifScoresState: MyOtifScoresState())
            
            globalLogger?.debug("\(#function) - AFTER: userState: Display Map \(browsingState.userPreferencesState.displayMapEnabled)  Display Featured Note \(browsingState.userPreferencesState.displayFeaturedLocationNoteEnabled)")
            
            return (.initialized(.authenticated(browsingState)), route)
        case .signOut:
            return (.initialized(.unauthenticated(LoginState())), AppCoordinator.RouteSegment.login.route())
        case .showLogin:
            let route = AppCoordinator.RouteSegment.login.route()
            return (state, route)
    }
}

//MARK: - Initial Download Action Reducer

func initialDownloadActionReducer(_ action: InitialDownloadAction, state: Initialization, route: Cordux.Route) -> (Initialization, Cordux.Route) {
    switch action {
      
    case let .complete(currentUser: rsr?, currentRoute: currentRoute, currentVehicle: currentVehicle, deliveryDays: deliveryDays, currentUserPreferencesState: currentUserPreferencesState):
        
        globalLogger?.debug("\(#function) -   Display Map: \(currentUserPreferencesState.displayMapEnabled) Display Featured Note: \(currentUserPreferencesState.displayFeaturedLocationNoteEnabled)")
        
        let browsingState = BrowsingState(rsr: rsr, routeName: currentRoute?.number,
                vehicleNumber: currentVehicle?.name, shouldUpdateDeliveriesList: false,
                currentDeliveryDay: nil, deliveryDays: deliveryDays, deliveryStops: [], deliveryDetailState: [:],
                checkoutState: nil, checkinState: nil, requestLoadState: nil, customerDetailState: [:], closeReasons: [],
                rescheduleReasons: [], freeItemReasons: [], returnItemReasons: [], returnEquipmentReasons: [],
                holdReasons: [], serviceRequestResolutionReasons: [], availableLanguages: [], currentDeliveryItem: nil, printerState: PrinterState(), emailState: EmailState(), filterDeliveriesState: FilterDeliveriesState(),
                userPreferencesState: currentUserPreferencesState, vehicleReplenishmentState: .initialized,
                vehicleState: .initialized, vehicleToVehicleReplenishmentState: .initialized, lunchState: LunchState(), reorderState: ReorderState(), otifScoresState: MyOtifScoresState())
       
        let route = AppCoordinator.RouteSegment.mainTabBar.route()
        return (.initialized(.authenticated(browsingState)), route)
    default:
        let route = route + LoginCoordinator.RouteSegment.signin.route()
        return (.initialized(.unauthenticated(LoginState())), route)
    }
}

 
 
 
 */
