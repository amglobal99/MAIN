//
//  UserLocationManager.swift
//  MAIN
//
//  Created by amglobal on 4/23/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux
import CoreLocation

protocol UserLocationManagerType {
    var provider: ProviderType! { get set }
    var rootViewController: UIViewController { get }

    func report(_ locations: [CLLocation])
}

final class UserLocationManager: UserLocationManagerType {
    
    var provider: ProviderType!
    let rootViewController: UIViewController
    fileprivate var store: Store<AppState>
    
    init(store: Store<AppState>, rootViewController: UIViewController) {
           self.store = store
           self.rootViewController = rootViewController
    }
        
        
        
    func report(_ locations: [CLLocation]) {
        
    }
    
    
}




/// ********* THIS IS FROM THE RSR APP *************************

/*
// Responsible for displaying initial auth request alert
// Responsible for receiving foreground notification and determining if we need to continuously display a go to settings alert
// Responsible for reporting locations to CB after check-out and before check-in

protocol UserLocationManagerType {
    var provider: ProviderType! { get set }
    var rootViewController: UIViewController { get }

    func report(_ locations: [CLLocation])
}

final class UserLocationManager: UserLocationManagerType, Providing {
    var provider: ProviderType!
    let rootViewController: UIViewController
    fileprivate var store: Store<AppState>
    fileprivate var foregroundObserver: NSObjectProtocol?
    fileprivate var dataController: GPSDataController
    fileprivate var settingsAlertController: UIAlertController?

    var currentRoute: String?
    var todaysDeliveryDay: DeliveryDayType?

    init(store: Store<AppState>, rootViewController: UIViewController) {
        self.store = store
        self.rootViewController = rootViewController

        dataController = GPSDataController()
        dataController.delegate = self

        setupNotification()
        setupStoreSubscription()
    }

    private func setupStoreSubscription() {
        store.subscribe(self) { state in return state}
    }

    deinit {
        guard let foregroundObserver = foregroundObserver else {
            return
        }
        NotificationCenter.default.removeObserver(foregroundObserver)
    }

    private func setupNotification() {
        foregroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { _ in
            // If Location Services have been deauthorized, alert the RSR
            if !self.dataController.validAuthorizationStatus {
                self.showLocationServicesAlert()
            }
        }
    }

    func report(_ locations: [CLLocation]) {
        guard let currentRoute = self.currentRoute, let todaysDeliveryDay = self.todaysDeliveryDay else {
            return
        }
        gpsProvider.capture(locations, routeNumber: currentRoute, deliveryDate: todaysDeliveryDay.date) { _ in

        }
    }
}

extension UserLocationManager: SubscriberType {

    func newState(_ state: AppState) {
        guard let browsingState = state.safeBrowsingState else {
            return
        }
        self.currentRoute = browsingState.routeName
        self.todaysDeliveryDay = browsingState.todaysDeliveryDay

        if browsingState.isInCheckedOutModeByCurrentUser && !browsingState.checkedIn {
            dataController.startLocationCapture()
        } else {
            dataController.stopLocationCapture()
        }
    }
}

extension UserLocationManager: GPSDataControllerDelegate {

    func userDeniedAuthorization() {
        showLocationServicesAlert()
    }

    fileprivate func showLocationServicesAlert() {
        // Don't show alert if it's already showing
        if let settingsAlertController = settingsAlertController, rootViewController.topMostViewController == settingsAlertController {
            return
        }
        let alertController = UIAlertController(title: NSLocalizedString("UserLocationManager.TurnOnLocationAlert.Title"),
                                                message: NSLocalizedString("UserLocationManager.TurnOnLocationAlert.Description"),
                                                preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: NSLocalizedString("UserLocationManager.TurnOnLocationAlert.ActionButton"),
                                           style: .default) { _ in
                                            let url = URL(string: UIApplication.openSettingsURLString)!
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        alertController.addAction(settingsAction)
        self.settingsAlertController = alertController
        rootViewController.topMostViewController.present(alertController, animated: true, completion: nil)
    }

    func update(_ locations: [CLLocation]) {
        report(locations)
    }
}

 
 
 
 */
