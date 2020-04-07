//
//  BrowsingState.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation



//MARK:- Browsing State

struct BrowsingState {
    
    var vehicleNumber: String?
    
    init(vehicleNumber: String?) {
        self.vehicleNumber = vehicleNumber
    }
    
}


//MARK:- Extension


extension BrowsingState {



    


}




//MARK:- REDUCER

/*
func browsingStateActionReducer(_ action: Action, state: BrowsingState, route: Cordux.Route) -> (InitializationKind, Cordux.Route) {
    let browsingState = BrowsingState(vehicleNumber: state.vehicleNumber)
    return (.initialized(.authenticated(browsingState)), route)
}



*/


