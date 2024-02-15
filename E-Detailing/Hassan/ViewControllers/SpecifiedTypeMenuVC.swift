//
//  SpecifiedTypeMenuVC.swift
//  E-Detailing
//
//  Created by San eforce on 08/02/24.
//

import Foundation
import UIKit
import CoreData
class SpecifiedMenuVC : BaseViewController {
    @IBOutlet var specifiedMenuView: SpecifiedMenuView!
    var menuDelegate : MenuResponseProtocol?
    var celltype: MenuView.CellType = .listedDoctor
    var selectedObject: NSManagedObject?
    var previewType: PreviewHomeView.PreviewType?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- initWithStory
    class func initWithStory(_ delegate : MenuResponseProtocol?, celltype: MenuView.CellType)-> SpecifiedMenuVC{
        
        let view : SpecifiedMenuVC = UIStoryboard.Hassan.instantiateViewController()
        view.modalPresentationStyle = .overCurrentContext
        view.celltype = celltype
        view.menuDelegate = delegate


        
        return view
    }
    
}
