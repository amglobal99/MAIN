//
//  AppState.swift
//  MAIN
//
//  Created by amglobal on 4/4/20.
//  Copyright © 2020 Natsys. All rights reserved.
//



/*
import UIKit
import Cordux
//import Bugsnag
//import CBL

typealias MainStore = Cordux.Store<AppState>?


let globalEnableV2VR : Bool = (ProcessInfo.processInfo.environment["V2VR_ENABLED"] == "YES")

class AppDelegate: UIResponder, UIApplicationDelegate {

    var windowCoordinator: WindowCoordinator!
    private var window: UIWindow? {
        return windowCoordinator.mainWindow
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CBL.globalLogger = globalLogger
        
        DatabaseDefaults.registerDefaults()

        Bugsnag.start(withApiKey: "2677fd388b4d213dba0c172449636e87")

        Theme.setup()
        UIViewController.swizzleLifecycleDelegatingViewControllerMethods()

        windowCoordinator = WindowCoordinator()

        windowCoordinator.start(Route())

        Localizer.SwizzleLocalizedString()
        
        UIViewController.preventPageSheetPresentation
        
        return true
    }
    
    func changeEnvironmentAndExit(_ env: EnvironmentKind) {
        guard DatabaseDefaults.currentEnvironment != env else {
            let alert = UIAlertController(title: "Environment Configuration", message: "The app is already using the \(env) environment.", preferredStyle: .alert)
            alert.addOKAction()
            window?.rootViewController?.present(alert, animated: false, completion: nil)
            return
        }
        
        
        if let _ = window?.rootViewController?.presentedViewController {
            window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
        
        let alert = UIAlertController(title: "Changing Environments", message: "The app will now shutdown and switch to the \(env) environment. Please re-open the app.", preferredStyle: .alert)
        alert.addOKAction() { _ in
            DatabaseDefaults.set(env)
            exit(0)
        }
        window?.rootViewController?.present(alert, animated: false, completion: nil)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        globalLogger?.debug("AppDelegate started with deep link url: \(url) options:\(options)")
        
        if url.scheme == "ideliver" {
            if url.path == "/config/environment/TEST" {
                changeEnvironmentAndExit(.TEST)
            } else if url.path == "/config/environment/DEV" {
                changeEnvironmentAndExit(.DEV)
            } else if url.path == "/config/environment/PROD" {
                changeEnvironmentAndExit(.PROD)
            } else if url.path == "/config/environment/PREPROD" {
                changeEnvironmentAndExit(.PREPROD)
            }
        }
        return true
    }
}



*/
