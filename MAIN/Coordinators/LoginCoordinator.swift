//
//  LoginCoordinator.swift
//  MAIN
//
//  Created by amglobal on 4/7/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux


//MARK: - Coordinator Class

class LoginCoordinator: Coordinator {
    
    enum RouteSegment: String, RouteConvertible {
        case lunchOut
        case language
    }
    
    let store: Store<AppState>
    var route: Cordux.Route = []
    
   // var provider: ProviderType!
   // var moreViewController: MoreViewController!
    var presentedCoordinator: AnyCoordinator?
    var _navigationController: UINavigationController!
   // var lunchCoordinator: LunchCoordinator?
    
    var rootViewController: UIViewController {
        return _navigationController
    }

    
    //MARK: - User Preferences
    
//    var currentPreferences: [UserPreferenceKind] = []
    var displayMapEnabled: Bool = true
    var displayFeaturedNoteEnabled:  Bool = false
    
    //MARK: - Initializer
    
    init(store: Store<AppState>) {
        self.store = store
    }

    //MARK: - Start
    
    func start(route: Cordux.Route) {
        print("Login Coordinator: ***** START ******")
        let loginViewController = LoginViewController.build()
       // moreViewController.handler = self
        loginViewController.corduxContext = Context(route, lifecycleDelegate: self)
        
        _navigationController = UINavigationController(rootViewController: loginViewController)
        _navigationController.navigationBar.isTranslucent = false
    }
    
    //MARK: - Push View Controller
    
    func push(_ coordinator: AnyCoordinator, route: Cordux.Route = []) {
        self.presentedCoordinator = coordinator
        coordinator.start(route: route)
        _navigationController.pushViewController(coordinator.rootViewController, animated: true)
    }
}






//MARK: - View Lifecycle Delegate

extension LoginCoordinator: ViewControllerLifecycleDelegate {
    
    func viewWillAppear(_ viewController: UIViewController) {
//        if let vc = viewController as? LoginViewController {
//            store.subscribe(vc, LoginViewDataSource.make(provider: provider))
//        }
        
       // store.subscribe(viewController)
    }
    
    func viewWillDisappear(_ viewController: UIViewController) {
        
      // store.unsubscribe(viewController)
        
    }
}

//MARK: - Handler for MoreViewController


















/*
import Foundation
import UIKit
import SafariServices
import Cordux
import PinkyPromise
import CBL

struct LoginSubscription {
    let initialization: Initialization

    init(_ state: AppState) {
        initialization = state.initialization
    }
}

//MARK: -  Login Coordinator

final class LoginCoordinator: NSObject, SceneCoordinator, SubscriberType, Providing {

    enum RouteSegment: String, RouteConvertible {
        case downloading
        case signin
    }

    var isObserving: Bool = false
    var scenePrefix: String = RouteSegment.downloading.rawValue

    let store: Store<AppState>
    var provider: ProviderType!
    var currentScene: AnyCoordinator?
    var credentialStore: CredentialStorageType = CredentialStorage()
    var loginController: LoginViewController?
    var flowingWaterContainer: BackgroundContainerViewController!
    var initialDownloadViewController: InitialDownloadViewController?
    var session: SessionType
    var syncDownloadTimer: Timer?
    var dependenciesAlreadyCalled = false
    
    var completion: DatabaseManagerSetupCompletion?
    var databaseManager: DBManagerType?

    var rootViewController: UIViewController {
        return flowingWaterContainer
    }

    init(store: Store<AppState>, session: SessionType, completion: @escaping DatabaseManagerSetupCompletion) {
        self.store = store
        self.session = session
        self.completion = completion
        super.init()
        store.subscribe(self, LoginSubscription.init)
    }

    func start(_ route: Cordux.Route) {
        flowingWaterContainer = UIViewController().wrapInFlowingWaterContainer()
        changeScene(RouteSegment.downloading.route())
    }

    func newState(_ state: LoginSubscription) {

    }

    func changeScene(_ route: Cordux.Route) {
        guard let segment = RouteSegment(rawValue: route.first ?? "") else {
            return
        }

        let new: UIViewController
        // eventually split these up into their own coordinators.
        switch segment {
        case .downloading:
            let downloadController = InitialDownloadViewController.build()
            downloadController.corduxContext = Context(RouteSegment.downloading.route(), lifecycleDelegate: self)
            downloadController.inject(self)
            self.initialDownloadViewController = downloadController
            new = downloadController
        case .signin:
            let (username, password) = debugEnvironmentCredentials
            let login = LoginViewController.build(with: username, password)
            login.corduxContext = Context(RouteSegment.signin.route(), lifecycleDelegate: self)
            login.inject(self)
            self.loginController = login
            new = login
        }

        scenePrefix = segment.rawValue
        flowingWaterContainer.replaceCurrentChildViewController(withViewController: new)
    }

    var debugEnvironmentCredentials: (username: String?, password: String?) {
        let username = ProcessInfo.processInfo.environment["LOGIN_USERNAME"]
        let password = ProcessInfo.processInfo.environment["LOGIN_PASSWORD"]
        return (username, password)
    }

    deinit {
        stopSyncStateObserving()
        stopDownloadTimer()
    }
    
    func stopSyncStateObserving() {
        if isObserving {
            observableSyncStateProvider.removeObserver(self, forKeyPath: SyncStateKeys.masterSyncState.rawValue)
            observableSyncStateProvider.removeObserver(self, forKeyPath: SyncStateKeys.routeSyncState.rawValue)
            isObserving = false
        }
    }
}

//MARK: -  Initializer

extension LoginViewModel {
    init(_ state: AppState) {
        guard case let .initialized(.unauthenticated(loginState)) = state.initialization else {
            self.isSigningIn = false
            return
        }
        self.isSigningIn = loginState.isSigningIn
    }
}

//MARK: -  View Lifecycle Events

extension LoginCoordinator: ViewControllerLifecycleDelegate {
    
    @objc func viewDidLoad(_ viewController: UIViewController) {
        switch viewController {
        case viewController as InitialDownloadViewController:
            DispatchQueue.main.async(execute: setupDatabase)
        default:
            break
        }
    }

    @objc func viewWillAppear(_ viewController: UIViewController) {
        switch viewController {
        case let viewController as LoginViewController:
            store.subscribe(viewController, LoginViewModel.init)
        default:
            break
        }
    }

    @objc func viewWillDisappear(_ vc: UIViewController) {
        guard let viewController = vc as? LoginViewController else {
            return
        }
        store.unsubscribe(viewController)
    }
}

//MARK: -  Extension for Login Coordinator

extension LoginCoordinator {
    
    var observableSyncStateProvider: NSObject {
        return provider.syncState as! NSObject
    }

    enum SyncStateKeys: String {
        case masterSyncState
        case routeSyncState
    }

    @nonobjc static let dbConfig: DatabaseConfigType = DatabaseConfigBuilder.getDBConfig(for: DatabaseDefaults.currentEnvironment)
    
    func setupDatabase() {
        configureDatabase()
        
        guard let dbMgr = databaseManager else {
            fatalError("database manager could not be setup")
        }
        //if the master data has not expired, start a timer to ensure that the user doesnt wait for sync'ing too long.
        //if they have never sync'd master (fresh install/deleted db) they will wait until it completes syncing
        if !dbMgr.hasMasterDataSyncExpired() {
            globalLogger?.debug("\(#function) 14 day master data is available. Starting the overwatch timer")
            syncDownloadTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(continuePastDownload),
                                                     userInfo: nil, repeats: false)
        }
        
        provider = Provider(databaseManager: dbMgr)
        observableSyncStateProvider.addObserver(self, forKeyPath: SyncStateKeys.masterSyncState.rawValue, options: [.initial,.new], context: nil)
        observableSyncStateProvider.addObserver(self, forKeyPath: SyncStateKeys.routeSyncState.rawValue, options: [.initial,.new], context: nil)
        isObserving = true

        configureNetworkMonitor()

        completion?(provider)
        completion = nil
    }

    func stopDownloadTimer() {
        if syncDownloadTimer != nil {
            globalLogger?.debug("\(#function) syncDownloadTimer is being invalidated")
            syncDownloadTimer?.invalidate()
            syncDownloadTimer = nil
            return
        }
        globalLogger?.debug("\(#function) syncDownloadTimer is nil")
    }
    
    func configureMockDatabase() {
        self.databaseManager = try! MockDBManager(dbConfig: LoginCoordinator.dbConfig)
    }
    
    func configureDatabase() {
        do {
            // instantiate the database
            databaseManager =  try DBManager(dbConfig: LoginCoordinator.dbConfig)
            // initialize the replicators
            databaseManager?.initialize(initialSyncProgressCallback: initialDatabaseStartupSyncProgressCallback)
        } catch let error {
            globalLogger?.error(error.localizedDescription)
            fatalError("Failed to start up/create database")
        }
    }

    func configureNetworkMonitor() {
        
        // NetworkMonitor and the callback closure lives for the duration the app
        // while LoginCoordinator should be deallocated after login is complete
        // this retains a reference to the store, but not to self, to avoid a memory leak
        let store = self.store
        self.databaseManager?.startNetworkMonitor { status in
            DispatchQueue.main.async {
                store.dispatch(ConnectionAction.updateConnectionStatus(status))
                globalLogger?.debug("⚡ Connection Status: \(status)")
            }
        }
    }

    func isLocationServicesAlert() -> Bool {
        if let alertView = self.rootViewController.presentedViewController, let alertTitle = alertView.title {
            if NSLocalizedString("UserLocationManager.TurnOnLocationAlert.Title") == alertTitle {
                return true
            }
        }
        return false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        guard let path = keyPath,
            let kpath = SyncStateKeys(rawValue: path) else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
                return
        }

        guard let change = change,
            let changeNumber = change[NSKeyValueChangeKey.newKey] as? Int,
            let newSyncState = SyncState(rawValue:changeNumber) else {
                return
        }

        switch (kpath, newSyncState) {
        case (.masterSyncState, .initialized):
            globalLogger?.info("\(kpath) \(newSyncState)")
            self.getDependencies()
        case (.masterSyncState, .error):
            globalLogger?.info("\(kpath) \(newSyncState)")
            presentOfflineAlert()
        case (.masterSyncState, .syncing):
            globalLogger?.info("\(kpath) \(newSyncState)")
            dismissOfflineAlertIfPresent()
        case (.masterSyncState, .uninitialized): fallthrough
        case (.routeSyncState, .uninitialized): fallthrough
        case (.routeSyncState, .error): fallthrough
        case (.routeSyncState, .syncing): fallthrough
        case (.routeSyncState, .initialized):
            globalLogger?.info("\(kpath) \(newSyncState)")
        }
    }

    func presentOfflineAlert() {
        DispatchQueue.main.async {
            self.showAlertNoAction(NSLocalizedString("LoginCoordinator.ApplicationOfflineAlert.Title"),
                                   message: NSLocalizedString("LoginCoordinator.ApplicationOfflineAlert.Body"))
        }
    }
    
    func dismissOfflineAlertIfPresent() {
        //this will bring down the app offline alert if it is present
        DispatchQueue.main.async {
            if !self.isLocationServicesAlert(){
                //if the titles matches location services alert, ignore dismissing it
                self.rootViewController.presentedViewController?.dismiss(animated: false)
            }
        }
    }
    
    @objc func continuePastDownload() {
        globalLogger?.debug("\(#function) continuing past download before sync is complete..user already has data.")
        getDependencies()
    }
    
    @nonobjc static var providerCompletedInitialization: Bool = false
    
    //MARK: -  Load Dependencies
    
    func getDependencies() {
        globalLogger?.debug("\(#function) called. LoginCoordinator.")
        
        //dont let this function get called twice
        guard !dependenciesAlreadyCalled else {
            globalLogger?.error("\(#function) call to getDependencies is being attempted more than once. skipping.")
            return
        }
        
        dependenciesAlreadyCalled = true
        stopDownloadTimer()
        stopSyncStateObserving()
        dismissOfflineAlertIfPresent()
        
        let currentDayPromises = firstly {
            return getVehicle()
        }.then { (route: RouteType?, vehicle: VehicleType?) -> Promise<(UserType?, RouteType?, VehicleType? )> in
            
            return PinkyPromise.zip(self.provider.user.currentUser(),
                                    (route != nil)   ? Promise(result: .success(route)) : self.provider.route.currentRoute(),
                                    (vehicle != nil) ? Promise(result: .success(vehicle)) : self.provider.vehicle.currentVehicle())
        }
        
        currentDayPromises.flatMap { (currentUser, currentRoute, currentVehicle) -> Promise<Void> in
            guard let currentUser = currentUser else {
                self.store.dispatch(InitialDownloadAction.complete(currentUser: nil, currentRoute: nil, currentVehicle: nil, deliveryDays: [], currentUserPreferencesState: UserPreferencesState() ))
                return Promise(result:.success(()))
            }
       
            let userPreferencesState = self.updateUserPreferences(currentUser: currentUser)
            self.store.dispatch(InitialDownloadAction.complete(currentUser: currentUser, currentRoute: currentRoute, currentVehicle: currentVehicle, deliveryDays: [], currentUserPreferencesState: userPreferencesState))
            
            guard let routeNumber = currentRoute?.number else {
                return Promise(result:.success(()))
            }

            return self.provider.route.deliveryDays(for: routeNumber).flatMap { deliveryDays in
                self.store.dispatch(DeliveriesAction.updateDeliveryDays(deliveryDays))
                guard let firstDay = deliveryDays.first else {
                    return Promise(result:.success(()))
                }
                self.store.dispatch(DeliveriesAction.updateDeliveryDay(firstDay))

                return self.routeProvider.stops(for: firstDay.route.number, date: firstDay.date, currentDeliveryDate: firstDay.date).map { deliveryStops in
                    self.store.dispatch(DeliveriesAction.updateDeliveryStops(deliveryStops))
                }.flatMap {
                    self.vehicleProvider.updateVehicleInventoryItems(store: self.store,
                                                                     route: firstDay.route.number,
                                                                     deliveryDate: firstDay.date)
                }.flatMap {
                    self.provider.lunch.updateLunchState(with: self.store, routeNumber: routeNumber, deliveryDate: firstDay.date, username: currentUser.username)
                }
            }
        }.call()
    }
    
    /// The following section is used to get user preferences from CBL.
    /// The UserPreferencesState is then updated with values obtained from CBL.
    func updateUserPreferences(currentUser: UserType) -> UserPreferencesState {
        var userPreferencesState = UserPreferencesState()
        globalLogger?.debug("UserState: GETDEPENDENCIES - calling CBL to update user state.")
        self.provider.user.userPreferences(for: currentUser.username)
        .onSuccess { [weak self]
            preferences in
            globalLogger?.debug("UserState: CBL value: \(preferences)")
            for userPreference in preferences {
                switch userPreference {
                case .deliveryDetailDisplayMap(let displayMapValue):
                    userPreferencesState.displayMapEnabled = displayMapValue
                case .deliveryDetailDisplayFeaturedNote(let featuredNoteValue):
                    userPreferencesState.displayFeaturedLocationNoteEnabled = featuredNoteValue
                case .applicationLanguage(let value):
                    userPreferencesState.applicationLanguage = value
                }
            }
            self?.store.dispatchMain(UserPreferencesStateAction.updateUserPreferencesState(preferences))
        }.call()
        return userPreferencesState
    }
    
    // get vehicle from checkout if user is currently checkedout, or from currentVehicle otherwise
    func getVehicle() -> Promise<(RouteType?, VehicleType?)> {
        
        return firstly {
           return provider.route.currentRoute()
        }.then { (currentRoute : RouteType?) -> Promise<(RouteType?, [DeliveryDayType])> in
            if let currentRoute = currentRoute {
                return PinkyPromise.zip(Promise(result: .success(currentRoute)),
                                        self.provider.route.deliveryDays(for: currentRoute.number))
            } else {
                return Promise(error: NSError(domain: "ideliver.water.com", code: 0, userInfo: nil))
            }
        }.then { (currentRoute: RouteType?, deliveryDays: [DeliveryDayType]) -> Promise<(RouteType?, VehicleType?)> in
            
            let getVehicle = firstly { () -> Promise<VehicleType?> in
                guard let firstDay = deliveryDays.first, let currentRoute = currentRoute else {
                    return Promise(error: NSError(domain: "ideliver.water.com", code: 0, userInfo: nil))
                }
                
                if (firstDay.isInCheckedOutModeByCurrentUser) {
                    return self.provider.vehicle.vehicleFromCheckout(for:currentRoute.number, deliveryDate: firstDay.date)
                } else {
                    return self.provider.vehicle.currentVehicle()
                }
            }
            
            return PinkyPromise.zip( Promise(result: .success(currentRoute)), getVehicle )
        }.recover({ (error: Error) -> Promise<(RouteType?, VehicleType?)> in
            let data : (RouteType?, VehicleType?) = (nil,nil)
            return Promise(result: .success(data))
        })
    }
    

}

//MARK: -  Handler

extension LoginCoordinator: LoginHandler {
    func showForgotPassword() {
        //TODO move this url into properties
        let forgotPasswordURL = URL(string: "https://resetpass.dsservices.com/showLogin.cc")!
        let safariViewController = SFSafariViewController(url: forgotPasswordURL)
        safariViewController.modalPresentationStyle = .formSheet
        rootViewController.present(safariViewController, animated: true, completion: nil)
    }

    func tappedEnvironmentButton() {
        let controller = ChangeEnvironmentViewController(style: .grouped, handler: self)
        let navigationController = UINavigationController(rootViewController: controller)
        rootViewController.present(navigationController, animated: true, completion: nil)
    }

    //called from the dbmanager
    func initialDatabaseStartupSyncProgressCallback(progress: DataReplicatorProgress) {
        self.updateProgressBar(progress: progress)
    }

    //updates the on-screen progress bar
    func updateProgressBar(progress: DataReplicatorProgress) {
        let updatedProgress = Float(progress.percentComplete/100)
        self.initialDownloadViewController?.countView.text = "\(progress.count)"
        self.initialDownloadViewController?.estimatedTotalView.text = "\(progress.estimatedTotal)"
        self.initialDownloadViewController?.syncStatus.text = "\(progress.state.description)"
        self.initialDownloadViewController?.progressView.progress = updatedProgress
    }

    //tapping on the downloading screens logo image calls this
    func tappedSkip() {
        //We dont want to do anything with it now, but is convienent testing trigger
        //so leaving this wired up, but does nothing.
        //self.continuePastDownload()
    }
    
    /// Function used to authenticate an user.
    /// - parameter username: the user's name
    /// - parameter password: user's password
    /// -returns: nothing
    func authenticateUser(_ username: String, password: String) {
        
        self.store.dispatch(LoginAction.isSigningIn(true))
        
        firstly {
            session.authenticate(username, password: password)
        }
        .recover { error in
            // Check keychain for credentials
            return Promise.lift {
                let error: UserDisplayError = error as? UserDisplayError ?? Login.Error.Server.userUnauthorized
                let isServerErrorButNotInvalidCredentials = (error as? Login.Error.Server).map { !$0.isInvalidCredentials } ?? false
                guard isServerErrorButNotInvalidCredentials || error is Login.Error.System,
                    self.credentialStore.checkCredentials(UserCredentials(username: username, password: password)) else {
                    throw error
                }
            }
        }
        .flatMap {
            self.userProvider.user(for: username)
        }
        .recover { error in
            return Promise.lift { throw (error as? UserDisplayError ?? Login.Error.Server.userUnauthorized) }
        }
        .tryMap { user in
            guard let user = user else {
                throw Login.Error.Server.userUnauthorized
            }
            return user
        }
        .onSuccess { _ in
            let userCredentials = UserCredentials(username: username, password: password)
            do {
                try self.credentialStore.storeCredentials(userCredentials)
            } catch {
                globalLogger?.error("occurred while storing credentials \(error)")
            }
        }
        .flatMap { user in
            self.userProvider.setNewCurrentUser(user)
        }
        .recover { error in
            return Promise.lift { throw (error as? UserDisplayError ?? Login.Error.System.unknown) }
        }
        .call { result in
            do {
                /// First, get the user from the result
                let user = try result.value()
                let userPreferencesState = self.updateUserPreferences(currentUser: user)
                var currentRoute: RouteType?
                self.provider.route.currentRoute().onSuccess {
                    route in currentRoute = route
                }.call()
                self.store.dispatch(AuthenticationAction.signIn(user: user, currentUserPreferencesState: userPreferencesState, currentRoute: currentRoute))
                
                // If a route is set (after auto logout), load the vehicle and delivery stops
                if let currentRoute = currentRoute {
                    self.routeProvider.deliveryDays(for: currentRoute.number) { result in
                        let days = result.requiredSuccessValue()
                        self.store.dispatch(DeliveriesAction.updateDeliveryDays(days))
                        if let firstDay = days.first {
                            firstly {
                                self.provider.vehicle.currentVehicle()
                                }.map { vehicle in
                                    self.store.dispatch(DeliveriesAction.updateVehicleNumber(vehicleNumber: vehicle?.name))
                                    self.store.dispatch(DeliveriesAction.updateDeliveryDay(firstDay))
                                    self.routeProvider.updateDeliveryStops(with: self.store, route: firstDay.route.number, date: firstDay.date, currentDeliveryDate: firstDay.date).call()
                                }.flatMap { _ in
                                    self.provider.vehicle.updateVehicleInventoryItems(store: self.store, route: currentRoute.number, deliveryDate: firstDay.date)
                                }.call()
                        }
                    }
                }
                self.store.route(.goto(AppCoordinator.RouteSegment.mainTabBar))
            } catch let error as UserDisplayError {
                self.loginController?.showErrorAlert(error)
                self.store.dispatch(LoginAction.loginError(error))
            } catch {
                failure(error)
            }
            self.store.dispatch(LoginAction.isSigningIn(false))
        }
    }
}

//MARK: -  Alerts

extension LoginCoordinator {
    
    func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("ActionButton.OK"), style: .default, handler: nil))
        rootViewController.present(alertController, animated: true, completion: nil)
    }

    func showAlertNoAction(_ title: String, message: String) {
        //dismiss alert if there is already one up
        if let alertView = rootViewController.presentedViewController, let alertTitle = alertView.title {
            if title == alertTitle {
                //if the titles match, just ignore
                return
            }
            rootViewController.presentedViewController?.dismiss(animated: false)
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        rootViewController.present(alertController, animated: true, completion: nil)
    }
}

//MARK: -  Cancel

extension LoginCoordinator: ChangeEnvironmentViewControllerHandler {
    func didCancel() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}

 
 
 
 */
