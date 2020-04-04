//
//  WindowCoordinator.swift
//  MAIN
//
//  Created by amglobal on 4/4/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import UIKit
import Cordux
//import Bugsnag
//import CBL

/*

enum WindowKind {
    case main
    case lunch
}

protocol WindowModelType {
    var isHidden: Bool { get }
}

struct WindowModel: WindowModelType {
    let isHidden: Bool
}

protocol WindowGroupModelType {
    var mainWindow: WindowModelType { get }
    var lunchWindow: WindowModelType { get }
    var keyWindow: WindowKind { get }
}

struct WindowGroupModel: WindowGroupModelType {
    let mainWindow: WindowModelType
    let lunchWindow: WindowModelType
    let keyWindow: WindowKind
}

extension WindowGroupModel {
    static func make() -> (AppState) -> WindowGroupModelType {
        return { (state) -> WindowGroupModelType in
            return WindowGroupModel(
                mainWindow: WindowModel(isHidden: !state.windowState.mainWindowVisible),
                lunchWindow: WindowModel(isHidden: !state.windowState.lunchWindowVisible),
                keyWindow: state.windowState.keyWindow
            )
        }
    }
}

fileprivate extension UIWindow.Level {
    static let normal = UIWindow.Level.normal
    static let vehicleToVehicle = normal + 1
    static let lunch = vehicleToVehicle + 1
    static let statusBar = UIWindow.Level.statusBar
    static let alert = UIWindow.Level.alert
}

class MockCoordinator: AnyCoordinator {
    var route = Cordux.Route()
    var rootViewController: UIViewController = UIViewController()
    func start(_ route: Cordux.Route) {
        rootViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}

class WindowCoordinator: Coordinator, Renderer {
    var route: Cordux.Route {
        get {
            return Route()
        }
        set {
            return
        }
    }
    let store: Store<AppState>

    var rootViewController: UIViewController {
        return mainWindow.rootViewController!
    }

    let mainWindow: UIWindow
    var coordinatorForMainWindow: AppCoordinator

    let lunchWindow: UIWindow
    var coordinatorForLunchWindow: AutoLunchCoordinator?
    
    var bugsnagNotifier: BugsnagMetadataNotifier!

    init() {
        let windowState = WindowState(keyWindow: .main)
        
        var state = AppState(windowState: windowState, connectionState: .uninitialized)
        
        // JE: previously we hid these error messages in production.
        // we keep getting the weird checkout error when user taps add item.
        // i would like to know what error they're getting
        if CrashCoordinator.recentCrashDetected() {
            state.route = AppCoordinator.RouteSegment.crashReporter.route()
        } else {
            state.route = AppCoordinator.RouteSegment.login.route()
        }
        store = Store(initialState: state, reducer: AppReducer())

        let mainViewController = BackgroundContainerViewController.build(withChild: UIViewController())

        coordinatorForMainWindow = AppCoordinator(store: store, container: mainViewController)
        
        let sessionGuid = NSUUID().uuidString
        bugsnagNotifier = BugsnagMetadataNotifier(store: store, session: sessionGuid)
        
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        lunchWindow = UIWindow(frame: UIScreen.main.bounds)

        setupMainWindow()
        coordinatorForMainWindow.windowCoordinator = self
        
        store.subscribe(self, WindowGroupModel.make())
    }
    
    func initAutoLunchCoordinator(store: Store<AppState>, provider: ProviderType) {
        coordinatorForLunchWindow = AutoLunchCoordinator(store: store, provider: provider)
        setupLunchWindow()
        coordinatorForLunchWindow?.start(Route())
    }

    private func setupMainWindow() {
        mainWindow.rootViewController = coordinatorForMainWindow.rootViewController
        mainWindow.tintColor = Theme.Colors.tealishColor()
        mainWindow.windowLevel = UIWindow.Level.normal
    }

    private func setupLunchWindow() {
        lunchWindow.rootViewController = coordinatorForLunchWindow?.rootViewController
        lunchWindow.tintColor = Theme.Colors.tealishColor()
        lunchWindow.windowLevel = UIWindow.Level.lunch
    }

    func start(_ route: Cordux.Route) {
        coordinatorForMainWindow.start(store.state.route)
        coordinatorForLunchWindow?.start(Route())
    }

    func render(_ viewModel: WindowGroupModel) {
        lunchWindow.isHidden = viewModel.lunchWindow.isHidden
        mainWindow.isHidden = viewModel.mainWindow.isHidden
        switch viewModel.keyWindow {
        case .lunch where !lunchWindow.isKeyWindow:
            lunchWindow.makeKey()
        case .main where !mainWindow.isKeyWindow:
            mainWindow.makeKey()
        default:
            break
        }
    }
}

 
 
 
 */

