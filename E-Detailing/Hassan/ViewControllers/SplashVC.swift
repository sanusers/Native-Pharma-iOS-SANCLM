//
//  SplashVC.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 03/05/24.
//


import Foundation
import UIKit

class SplashVC: BaseViewController{
    
 
    
    @IBOutlet var splashView: SplashView!
    var isFirstTimeLaunch : Bool = false
    var isTimeZoneChanged : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
      //  callCheckVersion()
    }
    
    
    class func initWithStory() -> SplashVC {
        let splash : SplashVC = UIStoryboard.Hassan.instantiateViewController()
       // splash.accViewModel = AccountViewModel()
        return splash
    }
    
    func callStartupActions(){
        
        self.splashView?.SplashImageHolderView.isHidden = false
        Shared.instance.showLoader(in: self.splashView.SplashImageHolderView, loaderType: .launch)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            UIView.animate(withDuration: 1, delay: 0, animations: {
                self.splashView?.SplashImageHolderView.isHidden = true
                Shared.instance.removeLoader(in: self.splashView.SplashImageHolderView)
                AppDelegate.shared.setupRootViewControllers(isFromlaunch: true)
            })
        }
        
       


    }
}

