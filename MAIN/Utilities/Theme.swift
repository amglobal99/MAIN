//
//  Theme.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import UIKit

enum Theme {

    static func setup() {
        UINavigationBar.appearance().titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: Theme.Colors.cursorColor()])
        UITextField.appearance().tintColor = .black
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = Theme.Colors.duckEggBlueColor()
        UITableViewCell.appearance().selectedBackgroundView = selectedBackgroundView
        UISwitch.appearance().onTintColor = Theme.Colors.tealishColor()
    }

    enum Metrics {

        enum Size {
            static let standardMargin: CGFloat = 12.0
            static let standardTableViewCellRowHeight: CGFloat = 44.0
            static let headerFooterOffset: CGFloat = 80.0
            static let standardSmallButtonHeight: CGFloat = 44.0
            static let preferredActionButtonHeight: CGFloat = 66.0
            static let standardBayContentHeight: CGFloat = 80.0
            static let sectionHeaderWithTitle: CGFloat = 40.0
            static let sectionEmptyHeader: CGFloat = 20.0
            static let imageEmptyStateMargin: CGFloat = 15.0
            static let footerButtonSpacing: CGFloat = 30.0
            static let homeIndicatorSafeAreaHeight: CGFloat = 26.0
        }

        enum CornerRadius {
            static let primary: CGFloat = 10.0
            static let secondary: CGFloat = 8.0
            static let contentView: CGFloat = 5.0
            static let lozenge: CGFloat = 3.0
        }

        enum BorderWidth {
            static let contentView: CGFloat = 1.0
            static let circular: CGFloat = 2.0
            static let circularAnimation: CGFloat = 3.8
        }

        enum BorderRadius {
            static let contentView: CGFloat = 1.0
        }

        enum Inset {
            static let buttomImageSpacing: CGFloat = 3.0
        }
        
        enum EdgeInsets {
            static let horizontalScroll: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            static let headerContentView: UIEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
            static let headerContentViewWithTitle: UIEdgeInsets = UIEdgeInsets(top: 40, left: 15, bottom: 0, right: 15)
            static let headerContentViewWithFooter: UIEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 15)
            static let leftButtonImage: UIEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            static let imageBayEdgeInsets = UIEdgeInsets(top: 0, left: -Inset.buttomImageSpacing, bottom: 0, right: Inset.buttomImageSpacing)
            static let titleBayEdgeInsets = UIEdgeInsets(top: 0, left: Inset.buttomImageSpacing, bottom: 0, right: -Inset.buttomImageSpacing)
            static let contentBayEdgeInsets = UIEdgeInsets(top: 0, left: Inset.buttomImageSpacing, bottom: 0, right: Inset.buttomImageSpacing)
            static let tableViewMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            static let centerContentView: UIEdgeInsets = UIEdgeInsets(top: 50, left: 36, bottom: 0, right: 36)
            static let centerLabelTopSpacing: UIEdgeInsets = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
            static let inlineContentView: UIEdgeInsets = UIEdgeInsets(top: 25, left: 10, bottom: 0, right: 10)
            static let fullContentView: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            static let indentedContentViewHeader: UIEdgeInsets = UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15)
            static let bayBottomMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
            static let tableViewMarginAllEdges: UIEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            static let emptyStateLabelMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 75)
            static let deliveryPointContainer: UIEdgeInsets = UIEdgeInsets(top: 5, left: 30, bottom: 20, right: 30)
        }
    }
    
    enum Fonts {
        static let megaLarge: UIFont = UIFont.systemFont(ofSize: 24)
        static let extraLargeBold: UIFont = UIFont.boldSystemFont(ofSize: 22.0)
        static let extraLarge: UIFont = UIFont.systemFont(ofSize: 20.0)
        static let large: UIFont = UIFont.systemFont(ofSize: 18.0)
        static let largeBold: UIFont = UIFont.boldSystemFont(ofSize: 18.0)
        static let primary: UIFont = UIFont.systemFont(ofSize: 16.0)
        static let primaryBold: UIFont = UIFont.boldSystemFont(ofSize: 16.0)
        static let small: UIFont = UIFont.systemFont(ofSize: 14.0)
        static let smallBold: UIFont = UIFont.boldSystemFont(ofSize: 14.0)
        static let extraSmall: UIFont = UIFont.systemFont(ofSize: 13.0)
        static let extraSmallBold: UIFont = UIFont.boldSystemFont(ofSize: 13.0)
        static let verySmall: UIFont = UIFont.systemFont(ofSize: 12.0)
        static let tiny: UIFont = UIFont.systemFont(ofSize: 11.0)
    }

    enum Colors {
        static func tealishColor() -> UIColor {
            return UIColor(red: 43.0/255.0, green: 188.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        }
        static func cursorColor() -> UIColor {
            return UIColor(white: 69.0/255.0, alpha: 1.0)
        }
        static func coralColor() -> UIColor {
            return UIColor(red: 248.0/255.0, green: 93.0/255.0, blue: 93.0/255.0, alpha: 1.0)
        }
        static func lightMustardColor() -> UIColor {
            return UIColor(red: 248.0 / 255.0, green: 184.0 / 255.0, blue: 93.0 / 255.0, alpha: 1.0)
        }
        static func silverColor() -> UIColor {
            return UIColor(red: 199.0 / 255.0, green: 199.0 / 255.0, blue: 205.0 / 255.0, alpha: 1.0)
        }
        static func borderGreyColor() -> UIColor {
            return UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
        }
        static func warmGreyColor() -> UIColor {
            return UIColor(white: 106.0/255.0, alpha: 1.0)
        }
        static func paleGreyColor() -> UIColor {
            return UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
        static func coolGreyColor() -> UIColor {
            return UIColor(red: 164.0/255.0, green: 170.0/255.0, blue: 179.0/255.0, alpha: 1.0)
        }
        static func duckEggBlueColor() -> UIColor {
            return UIColor(red: 223.0/255.0, green: 248.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        }
        static func paleGrey25Color() -> UIColor {
            return UIColor(red: 253.0/255.0, green: 253.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        }
        static func tealishTwoColor() -> UIColor {
            return UIColor(red: 149.0/255.0, green: 221.0/255.0, blue: 223.0/255.0, alpha: 1.0)
        }
        static func slateGreyColor() -> UIColor {
            return UIColor(red: 109.0 / 255.0, green: 109.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
        }
        static func paleGreyTwoColor() -> UIColor {
            return UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
        }
        static func backgroundGreyColor() -> UIColor {
            return UIColor(red: 251.0 / 255.0, green: 251.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
        }
        static func lightSilverColor() -> UIColor {
            return UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
        }
        static func drPaleGreyThreeColor() -> UIColor {
            return UIColor(red: 244.0 / 255.0, green: 244.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        }
        static func realDealTeal() -> UIColor {
            return UIColor(red: 23.0 / 255.0, green: 146.0 / 255.0, blue: 149.0 / 255.0, alpha: 1.0)
        }
        
        static func mostlyBlack() -> UIColor {
            return UIColor(red: 3.0 / 255.0, green: 3.0 / 255.0, blue: 3.0 / 255.0, alpha: 1.0)
        }
        
        static func waterBlueColor() -> UIColor {
            return UIColor(red: 0.0/255.0, green: 154.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        
        static func coffeeBrownColor() -> UIColor {
            return UIColor(red: 161.0/255.0, green: 117.0/255.0, blue: 7.0/255.0, alpha: 1.0)
        }
        
        static func filtrationPurpleColor() -> UIColor {
            return UIColor(red: 146.0/255.0, green: 52.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        }
        
        static func darkerBlue() -> UIColor {
             return UIColor(red: 21.0/255.0, green: 11.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        }
        
        static func mapRouteBlue() -> UIColor {
            return UIColor(red: 0.0/255.0, green: 165.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
    }

    enum Alpha {
        static let evenMoreDisabled: CGFloat = 0.25
        static let disabled: CGFloat = 0.4
        static let enabled: CGFloat = 1.0
    }

    enum AnimationDuration {
        static let highlightDuration: Double = 0.7
    }

    enum Header {
        static func empty() -> UIView {
            return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        }

    }
}

extension UIFont {
    //returns back the height of a given text based on the font it is using and the width of the UI object it is displaying it.
    //This can help you figure out numberOfLines if you use:  result/font.lineHeight
    func calculateHeight(text: String, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): self]),
                                            context: nil)
        return boundingBox.height
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}
