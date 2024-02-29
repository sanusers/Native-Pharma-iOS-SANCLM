//
//  Pipelines.swift
//  E-Detailing
//
//  Created by San eforce on 29/02/24.
//

import Foundation
import UIKit
class Pipelines  {
    static let shared = Pipelines()
    
    let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    
   
    var window: UIWindow?
    
    func doLogout() {
        window = appDelegate.window
        self.window?.rootViewController = UINavigationController.init(rootViewController: UIStoryboard.loginVC)
    }
    
}
