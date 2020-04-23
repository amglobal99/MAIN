//
//  LoginViewController.swift
//  MAIN
//
//  Created by amglobal on 4/23/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import UIKit
import Cordux



//MARK: - Handler Protocol

protocol LoginViewControllerHandler: class {
    func logOut()
    func lunchOut()
   // func updateSwitchToggle(_ toggle: DeliveryDetailsSwitchItemType)
    func sendDiagnostics()
    func clearDatabase()
    func chooseLanguage()
    func refreshSyncInfo()
}

//MARK:- View Controller

/// This class serves as the view controller for the 'More' screen.
/// This screen is presented when a user clicks the 'More' option on the bottom tab bar.
/// The coordinator for this view controller is defined in MoreCoordinator.swift
/// The table view used on this screen utilizes the following cell types to display the various rows:
///     - RightDetailTableViewCell
///     - DeviceStatusTableViewCell
///     - SwitchItemTableViewCell
class LoginViewController: UIViewController {

    weak var handler: MoreViewControllerHandler?
    

    // MARK: - Initial Setup
    
    /// called from the start func in LoginCoordinator.swift
    class func build() -> LoginViewController {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.tabBarItem.title = "Login"
        vc.tabBarItem.image = UIImage(named: "icoHelpSelected")
        vc.tabBarItem.selectedImage = UIImage(named: "icoHelpSelected")
        vc.title = "Login"
        vc.view.backgroundColor = Theme.Colors.backgroundGreyColor()
        return vc
    }
    
    override func viewDidLoad() {
        
    }
    

}
