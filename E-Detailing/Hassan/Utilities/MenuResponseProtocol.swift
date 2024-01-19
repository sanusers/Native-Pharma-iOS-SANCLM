import Foundation
import UIKit

protocol MenuResponseProtocol {
    func routeToView(_ view : UIViewController)
    func callPlanAPI()
   // func callAdminForManualBooking()
   // func openThemeActionSheet()
   // func changeFont()
   // func routeToHome(_ view: UIViewController)

}
extension MenuResponseProtocol where Self : UIViewController{
    func callAdminForManualBooking() {
       // self.checkMobileNumeber()
    }
    func openThemeActionSheet(){
        //self.openThemeSheet()
    }
    func routeToView(_ view: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(view, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backAction"), object: self, userInfo: nil)
        self.navigationController?.pushViewController(view, animated: true)
        self.navigationController?.presentInFullScreen(view, animated: true, completion: nil)
    }
    func routeToHome(_ view: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.modalPresentationStyle = .overFullScreen
        self.navigationController?.presentInFullScreen(view, animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backAction"), object: self, userInfo: nil)
        self.navigationController?.pushViewController(view, animated: true)
        self.navigationController?.presentInFullScreen(view, animated: true, completion: nil)
    }
    func changeFont() {
        //self.openChangeFontSheet()
    }
    }

// Thanks to the author @Hassan
