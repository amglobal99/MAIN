//
//  AppDelegate.swift
//  MAIN
//
//  Created by amglobal on 4/3/20.
//  Copyright © 2020 Natsys. All rights reserved.
//


/*
import UIKit

@UIApplicationMain



class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

*/





import UIKit
import Cordux

typealias MainStore = Cordux.Store<AppState>?


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var windowCoordinator: WindowCoordinator!
    
    private var window: UIWindow? {
        return windowCoordinator.mainWindow
    }

    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //CBL.globalLogger = globalLogger
        
        //DatabaseDefaults.registerDefaults()

       // Bugsnag.start(withApiKey: "2677fd388b4d213dba0c172449636e87")

       //  Theme.setup()
        UIViewController.swizzleLifecycleDelegatingViewControllerMethods()

        windowCoordinator = WindowCoordinator()

        windowCoordinator.start(route: Route())

        
        //Localizer.SwizzleLocalizedString()
        
       // UIViewController.preventPageSheetPresentation
        
        return true
    }
    
    
    
    
    
    
    
    
    
    
    /*
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
 
 
 */
 
 
 
}





