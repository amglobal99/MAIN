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

public protocol ProviderType {
    var route: RouteProviderType { get }
    var notes: NotesProviderType { get }
}


public protocol RouteProviderType {

}


public protocol NotesProviderType {

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
