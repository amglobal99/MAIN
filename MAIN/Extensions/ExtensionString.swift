//
//  ExtensionString.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//


import UIKit


extension String {
  
  /// Converts a string value to a NSDecimalNumber
  /// usage:
  /// var priceStr = "367.875"
  /// var itemPrice:NSDecimalNumber = priceStr.toNSDecimal()
  ///
  /// - Returns: a NSDecimalNumber or 0 if not successful
  func toNSDecimal() -> NSDecimalNumber {
    return GlobalConstants.numberFormatter.number(from: self) as? NSDecimalNumber ?? 0
  }
  

  /// Function creates a NSDecimalNumber from a String value.
  /// Returns a nil if function cannot create a NSDecimelNumber
  /// var grandTotal: String  = "36.967"
  ///
  ///  var grnd = grandTotal.getNSDecimalNumber()
  ///   if let grnd = grandTotal.getNSDecimalNumber() {
  ///     print(grnd)
  ///   } else {
  ///     print("Not a nil")
  ///   }
  
  func getNSDecimalNumber() -> NSDecimalNumber?  {
    return GlobalConstants.numberFormatter.number(from: self) as? NSDecimalNumber
  }

  
  public func trunc(length: Int) -> String {
      return (self.count > length) ? String(self.prefix(length)) : self
  }
  
    public var decimalNumber: NSDecimalNumber? {
          return Formatters.decimalFormatter.number(from: self) as? NSDecimalNumber
      }
  
} // end extension




extension NSMutableAttributedString {
    
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = .center
        let attrs: [NSAttributedString.Key: Any] = [.font: Theme.Fonts.smallBold,
                                                    .paragraphStyle: paraStyle]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        return self
    }

    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = .center
        let attrs: [NSAttributedString.Key: Any] = [.font: Theme.Fonts.small,
                                                    .paragraphStyle: paraStyle]
        let normalString = NSMutableAttributedString(string:text, attributes: attrs)
        append(normalString)
        return self
    }
}
