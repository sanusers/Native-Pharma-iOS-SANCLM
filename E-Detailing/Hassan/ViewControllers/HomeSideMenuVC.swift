//
//  HomeSideMenuVC.swift
//  E-Detailing
//
//  Created by San eforce on 10/01/24.
//

import Foundation
import UIKit



class HomeSideMenuVC: BaseViewController {
    @IBOutlet weak var menuView : HomeSideMenuView!
    var menuDelegate : MenuResponseProtocol?
    //MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.setprofileInfo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- initWithStory

 
    class func initWithStory(_ delegate : MenuResponseProtocol?)-> HomeSideMenuVC{
        
        let view : HomeSideMenuVC = UIStoryboard.Hassan.instantiateViewController()
        view.modalPresentationStyle = .overCurrentContext

        view.menuDelegate = delegate


        
        return view
    }
    
}
