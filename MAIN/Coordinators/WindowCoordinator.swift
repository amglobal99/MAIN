///
///  WindowCoordinator.swift
///  MAIN
///
///  Created by amglobal on 4/4/20.
///  Copyright © 2020 Natsys. All rights reserved.
///

import UIKit
import Cordux

//MARK:- Protocols

protocol WindowModelType {
    //var isHidden: Bool { get }
}

protocol WindowGroupModelType {
    var mainWindow: WindowModelType { get }
    var keyWindow: WindowKind { get }
}

enum WindowKind {
    case main
    // case lunch /// Use for second window
}

//MARK:- Window Model

struct WindowModel: WindowModelType {
    let isHidden: Bool
}

//MARK:- Window Group Model

struct WindowGroupModel: WindowGroupModelType {
    let mainWindow: WindowModelType
    let keyWindow: WindowKind
}

//MARK:- make()

extension WindowGroupModel {
    
    static func make() -> (AppState) -> WindowGroupModelType {
        return { (state) -> WindowGroupModelType in
            return WindowGroupModel(
                mainWindow: WindowModel(isHidden: !state.windowState.mainWindowVisible),
                keyWindow: state.windowState.keyWindow
            )
        }
    }
    
}

 
 
 
 /*
fileprivate extension UIWindow.Level {
    static let normal = UIWindow.Level.normal
    static let vehicleToVehicle = normal + 1
    static let lunch = vehicleToVehicle + 1
    static let statusBar = UIWindow.Level.statusBar
    static let alert = UIWindow.Level.alert
}

 
*/



//MARK:- COORDINATOR

class WindowCoordinator: Coordinator, Renderer {
    
    let mainWindow: UIWindow
    let store: Store<AppState>
    var coordinatorForMainWindow: AppCoordinator
    
    var route: Cordux.Route {
        get {
            return Route()
        }
        set {
            return
        }
    }
    
    var rootViewController: UIViewController {
        return mainWindow.rootViewController!
    }

    
    
    /// This initializer is called from the 'application(_ application: UIApplication, didFinishLaunchingWithOptions' function
    /// in AppDelegate.swift
    init() {
        /// create Window State
        let windowState = WindowState(keyWindow: .main)
        
        /// create App State
        let state = AppState(windowState: windowState, connectionState: .uninitialized)
        
        /// create store
        store = Store(initialState: state, reducer: AppReducer())
        
        let mainViewController = BackgroundContainerViewController.build(withChild: UIViewController())
        
        /// assign coordinator for main window
        coordinatorForMainWindow = AppCoordinator(store: store, container: mainViewController)
        
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        //  lunchWindow = UIWindow(frame: UIScreen.main.bounds)
        
        setupMainWindow()
        coordinatorForMainWindow.windowCoordinator = self
        
        /// subscribe to store
        store.subscribe(self, WindowGroupModel.make())
    }
    
    
    
    private func setupMainWindow() {
        mainWindow.rootViewController = coordinatorForMainWindow.rootViewController
        mainWindow.tintColor = UIColor.gray
        mainWindow.windowLevel = UIWindow.Level.normal
    }

    
    //MARK:- START
    
    /// called from ' func application(_ application: UIApplication, didFinishLaunchingWithOptions ....' function in AppDelegate.swift
    func start(route: Cordux.Route) {
        print("Window Coordinator: start()")
        coordinatorForMainWindow.start(route: store.state.route)
    }


    //MARK:- RENDER
    
    func render(_ viewModel: WindowGroupModel) {
        //mainWindow.isHidden = viewModel.mainWindow.isHidden
        switch viewModel.keyWindow {
        case .main where !mainWindow.isKeyWindow:
            /// Use this method to make the window key without changing its visibility.
            /// The key window receives keyboard and other non-touch related events.
            mainWindow.makeKey()
        default:
            break
        }
    }
    
}//end class

