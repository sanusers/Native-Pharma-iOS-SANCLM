//
//  Fonts and Colore.swift
//  E-Detailing
//
//  Created by San eforce on 20/11/23.
//

import Foundation
import UIKit
class Themes: NSObject {
    static let externalBorderName = "externalBorder"
    static let appGreyColor = UIColor.init(red: 238, green: 238, blue: 238)
    static let appSelectionColor = UIColor.init(red: 40, green: 42, blue: 60).withAlphaComponent(0.1)
    static let appTextColor = UIColor.init(red: 40, green: 42, blue: 60).withAlphaComponent(0.65)
    static let appWhiteColor = UIColor.init(red: 255, green: 255, blue: 255)
    static let appDarkBlueColor = UIColor.init(red: 53, green: 57, blue: 77)
}


extension UIColor {
  
    static var appGreyColor = Themes.appGreyColor
    static var appSelectionColor = Themes.appSelectionColor
    static var appTextColor = Themes.appTextColor
    static var appWhiteColor = Themes.appWhiteColor
    
    
}

extension UIColor {


    //MARK: hex Extention
    public  convenience init(hex : String?) {
        guard let hex = hex else {
            self.init()
            return }

        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension CGFloat {
    static let EXTRALARGE :CGFloat = 52
    static let LARGE :CGFloat = 35
    static let HEADER:CGFloat = 20
    static let SUBHEADER:CGFloat = 16
    static let BODY:CGFloat = 14
    static let SMALL:CGFloat = 12
    static let TINY:CGFloat = 10
}


enum CustomFont {
    
    case bold(size:CGFloat)
    case light(size:CGFloat)
    case medium(size:CGFloat)
 
    
    var instance:UIFont {
        switch self {
        case .bold(size: let size):
            return UIFont(name: Fonts.SATOSHI_BOLD, size: size)!
        case .light(size: let size):
            return UIFont(name: Fonts.SATOSHI_LIGHT, size: size)!
        case .medium(size: let size):
            return UIFont(name: Fonts.SATOSHI_MEDIUM, size: size)!
        }
    }

}


class Fonts:NSObject{
    static let SATOSHI_BOLD = "Satoshi-Bold"
    static let SATOSHI_LIGHT = "Satoshi-Light"
    static let SATOSHI_MEDIUM = "Satoshi-Medium"
}
