//
//  AppReducer.swift
//  MAIN
//
//  Created by amglobal on 4/4/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux

public enum ActionLoggingLevel {
    case none
    case actionName
    case actionDetails
}

//MARK: - Protocol

public protocol ActionLogPrintable {
    var logLevel: ActionLoggingLevel { get }
}

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

//MARK: - App Reducer

struct AppReducer: Reducer {

    func handleAction(_ action: Action, state: AppState) -> AppState {
        
        print("Handling action: \(type(of:action)).\(action.shortName)")
        
        let (intialization, route) = initializationReducer(action, state: state.initialization, route: state.route)
        
        return AppState(route: route,
                        initialization: intialization,
                        windowState: windowsReducer(action, state: state.windowState),
                        connectionState: connectionReducer(action, state: state.connectionState))
    }
}




//MARK: - Windows Reducer

func windowsReducer(_ action: Action, state: WindowState) -> WindowState {
    
    guard let windowAction = action as? WindowAction else {
        return state
    }
    
    switch windowAction {
    case .setKeyWindow(let kind):
        return WindowState(keyWindow: kind,
                           mainWindowVisible: state.mainWindowVisible,
                           lunchWindowVisible: state.lunchWindowVisible)
    case .setWindowVisible(let kind, let visible):
        switch kind {
        case .main:
            return WindowState(keyWindow: state.keyWindow,
                               mainWindowVisible: visible,
                               lunchWindowVisible: state.lunchWindowVisible)
        case .lunch:
            return WindowState(keyWindow: state.keyWindow,
                               mainWindowVisible: state.mainWindowVisible,
                               lunchWindowVisible: visible)
        }
    }
}



//MARK: - Connection Reducer

func connectionReducer(_ action: Action, state: ConnectionStateKind) -> ConnectionStateKind {
    guard let connectionAction = action as? ConnectionActionKind,
        case let .updateConnectionStatus(newStatus) = connectionAction else {
        return state
    }
    
    return .initialized(newStatus)
}





//MARK:-  Initialization Reducer



func initializationReducer(_ action: Action, state: InitializationKind, route: Cordux.Route) -> (InitializationKind, Cordux.Route) {
    switch (action, state) {
//    case let (action as InitialDownloadAction, _):
//        return initialDownloadActionReducer(action, state: state, route: route)
//    case let (action as LoginAction, .initialized(.unauthenticated(loginState))):
//        return (.initialized(.unauthenticated(loginActionReducer(action, state: loginState))), route)

    default:
        return (state, route)
    }
    return (state, route)
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
