//
//  MoreViewController.swift
//  MAIN
//
//  Created by amglobal on 4/8/20.
//  Copyright © 2020 Natsys. All rights reserved.
//


import Foundation
import UIKit
import Cordux
//import CBL



//MARK: - Handler Protocol

protocol MoreViewControllerHandler: class {
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
class MoreViewController: UIViewController {

    weak var handler: MoreViewControllerHandler?
    

    // MARK: - Initial Setup
    class func build() -> MoreViewController {
        let storyboard = UIStoryboard(name: "MoreViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        vc.tabBarItem.title = "More Tab"
        vc.tabBarItem.image = UIImage(named: "icoMore")
        vc.tabBarItem.selectedImage = UIImage(named: "icoMoreSelected")
        vc.title = "MORE OPTIONS"
        vc.view.backgroundColor = Theme.Colors.backgroundGreyColor()
        return vc
    }
    
    override func viewDidLoad() {
    }
    

}
