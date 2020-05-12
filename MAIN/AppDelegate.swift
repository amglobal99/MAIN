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
import CoreData


public enum EnvironmentKind: String {
    case DEV = "2-Development"
    case TEST = "3-Test"
    case PREPROD = "3a-Pre-Production"
    case PROD = "4-Production"
}


typealias MainStore = Cordux.Store<AppState>?


@UIApplicationMain

//MARk:- *********** APP DELEGATE Class ****************

class AppDelegate: UIResponder, UIApplicationDelegate {

    var windowCoordinator: WindowCoordinator!
    
    private var window: UIWindow? {
        return windowCoordinator.mainWindow
    }

    //MARK:- ******* DID FINISH LAUNCHING ************
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIViewController.swizzleLifecycleDelegatingViewControllerMethods()
        /// Initialize Window Coordinator. The coordinator for main window is specified there (AppCoordinator)
        windowCoordinator = WindowCoordinator()
        windowCoordinator.start(route: Route())
        return true
    }
    
    
    
    
    
    
    /*
    
    func changeEnvironmentAndExit(_ env: EnvironmentKind) {
        if let _ = window?.rootViewController?.presentedViewController {
            window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
        let alert = UIAlertController(title: "Changing Environments", message: "The app will now shutdown and switch to the \(env) environment. Please re-open the app.", preferredStyle: .alert)
        window?.rootViewController?.present(alert, animated: false, completion: nil)
    }
    
     
     
     
     
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("AppDelegate started with deep link url: \(url) options:\(options)")
        
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
 
 
   // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Discard")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
 
} //end class





