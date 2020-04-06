//
//  WindowState.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation

//MARK:- Window State

struct WindowState {
    
    let keyWindow:  WindowKind
    let mainWindowVisible: Bool
    let lunchWindowVisible: Bool
    
    init(keyWindow: WindowKind,
         mainWindowVisible: Bool = true,
         lunchWindowVisible: Bool = false) {
        
        self.keyWindow = keyWindow
        self.mainWindowVisible = mainWindowVisible
        self.lunchWindowVisible = lunchWindowVisible
    }
}


