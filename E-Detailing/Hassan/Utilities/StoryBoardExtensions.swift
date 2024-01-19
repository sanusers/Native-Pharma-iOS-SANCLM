//
//  StoryBoardExtensions.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import Foundation
import UIKit

extension UIViewController: ReusableView { }

extension UIStoryboard {
    
    static var Hassan : UIStoryboard{
        return UIStoryboard(name: "Hassan", bundle: nil)
    }
    
    func instantiateViewController<T>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as! T
    }
    /**

     */
    func instantiateIDViewController<T>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier + "ID") as! T
    }
    
}

//MARK:- Extensions
protocol ReusableView: AnyObject {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
  
}
// Thanks to the author @Hassan
