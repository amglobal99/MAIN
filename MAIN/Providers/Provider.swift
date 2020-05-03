//
//  Provider.swift
//  MAIN
//
//  Created by amglobal on 4/23/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation

//MARK:- ****** ENUMS **********

public enum AppFlowState {
    case loggedOut
    case preCheckout
    case checkedOut
}

//MARK:- ******* Protocols ************

public protocol Providing {
    var provider: ProviderType! { get }
}

public protocol ProviderType {
    var route: RouteProviderType { get }
    var notes: NotesProviderType { get }
}

public protocol RouteProviderType {
    /// Return all routes across all branches
    func allRoutes(_ completion: (Result<[RouteType], Error>) -> Void)
}

public protocol NotesProviderType {}

public protocol RouteType {
    /// Alphanumeric identifier for a route. - Note: This is unique
    var number: String { get }
    var branch: String { get }
    // since UserType references RouteType, i'm trying to avoid a UserType here.
    var defaultUserFullName: String? { get }
}




//MARK:- ************* PROVIDER **************

open class Provider: ProviderType {
    public let route: RouteProviderType
    public let notes: NotesProviderType
   
    public init(route: RouteProviderType, notes: NotesProviderType) {
        self.route = route
        self.notes = notes
    }
}


//MARK:- ********** PROVIDING ****************

extension Providing {
    var routeProvider: RouteProviderType { return provider.route }
    var notesProvider: NotesProviderType { return provider.notes }
}
