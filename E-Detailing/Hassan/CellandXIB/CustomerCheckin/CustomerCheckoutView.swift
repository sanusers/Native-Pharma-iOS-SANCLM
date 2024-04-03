//
//  CustomerCheckoutView.swift
//  E-Detailing
//
//  Created by San eforce on 03/04/24.
//

import Foundation
import UIKit
class CustomerCheckoutView: UIView {
    
    @IBOutlet var addressLbl: UILabel!
    
    @IBOutlet var longitudeLbl: UILabel!
    @IBOutlet var latitudeLbl: UILabel!
    @IBOutlet var checkoutTimeLbl: UILabel!
    
    
    var appsetup : AppSetUp?
    var delegate:  addedSubViewsDelegate?
    var chckinInfo: CheckinInfo?
    
    
    
    
}
