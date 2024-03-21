//
//  AddproductsMenuVC.swift
//  E-Detailing
//
//  Created by San eforce on 21/03/24.
//

import Foundation
import UIKit
class AddproductsMenuVC : BaseViewController {
    @IBOutlet var addproductsMenuView: AddproductsMenuView!
    var menuDelegate : MenuResponseProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- initWithStory
    class func initWithStory(_ delegate : MenuResponseProtocol?)-> AddproductsMenuVC{
        
        let view : AddproductsMenuVC = UIStoryboard.Hassan.instantiateViewController()
        view.modalPresentationStyle = .overCurrentContext
      
        view.menuDelegate = delegate


        
        return view
    }
}
