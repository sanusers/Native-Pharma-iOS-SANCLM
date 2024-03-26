//
//  swift
//  E-Detailing
//
//  Created by San eforce on 20/03/24.
//

import Foundation
import UIKit
class AddCallinfoVC: BaseViewController {
    @IBOutlet var addCallinfoView: AddCallinfoView!
    
    var dcrCall : CallViewModel!
    
    class func initWithStory() -> AddCallinfoVC {
        let reportsVC : AddCallinfoVC = UIStoryboard.Hassan.instantiateViewController()
      
       // reportsVC.pageType = pageType
        return reportsVC
    }
    
}
