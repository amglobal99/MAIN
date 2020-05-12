//
//  GlobalConstants.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation


typealias ClosureJSON<T> = (T) -> Void




struct GlobalConstants {
  
  
  
      // MARK: - Constants
  
//      static let githubAPIManager = GitHubAPIManager.sharedInstance
//      static let globalHelper = GlobalHelper.sharedInstance
//      static let internetConnectionHelper = InternetConnectionHelper.sharedInstance

      static let companyName = "Natsys International"
      static let companyAddress = "1808 Mountain Lake Dr GA 30339"
      static let userDefaults = UserDefaults.standard
      
      static let filemgr = FileManager.default
      static let calendar: Calendar = Calendar(identifier: .gregorian )
      static let locale = Locale(identifier: "en_US")
      
      // Date Formatter
      static let dateFormatter: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
      }()
  
  
      // Number formatter
      static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        return formatter
      }()
  
  
      // Session
      static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
      }()
  

      // NSDecimalHandler
      static let handler = NSDecimalNumberHandler(
        roundingMode: NSDecimalNumber.RoundingMode.bankers,
        scale: 2,
        raiseOnExactness: false,
        raiseOnOverflow: false,
        raiseOnUnderflow: false,
        raiseOnDivideByZero: false
      )

    
  
  
  
  
}  // end struct GlobalConstants






struct CommonFunctions {
    
    
    
    
}
