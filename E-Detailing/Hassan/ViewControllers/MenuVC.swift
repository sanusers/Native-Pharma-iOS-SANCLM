//
//  MenuVC.swift
//  PlannerApp
//
//  Created by APPLE on 03/11/23.
//


import UIKit
import Foundation
//import SDWebImage

protocol MenuResponseProtocol: AnyObject {
func callPlanAPI()
func sessionRemoved()
}
  


class MenuVC: BaseViewController {

    
  
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return self.traitCollection.userInterfaceStyle == .dark ? .lightContent : .darkContent
//    }
    
    @IBOutlet weak var menuView : MenuView!

    
//    @IBOutlet weak var menuHeaderHeight: NSLayoutConstraint!
    
    var sessionDetailsArr : SessionDetailsArr?
    weak var menuDelegate : MenuResponseProtocol?
    var selectedDate : Date?
    var isForWeekoff = Bool()
    var isWeekoffEditable : Bool = true
  //  var accountViewModel : AccountViewModel?
    var dictParms = [String: Any]()
    var imageURL = ""
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
    class func initWithStory(_ delegate : MenuResponseProtocol?, _ date: Date, isForWeekOff: Bool?)-> MenuVC{
        
        let view : MenuVC = UIStoryboard.Hassan.instantiateViewController()
        view.modalPresentationStyle = .overCurrentContext
        view.selectedDate = date
        view.isForWeekoff = isForWeekOff ?? false
        view.menuDelegate = delegate


        
        return view
    }

    
    
    func removeAllNotication() {

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.menuView.ThemeUpdate()
    }
    // AFTER USER LOGOUT, WE SHOULD RESET WORK/HOME LOCATION DETAILS

    
    
}


class CellMenus: UITableViewCell
{
    @IBOutlet var lblName: UILabel?
}

