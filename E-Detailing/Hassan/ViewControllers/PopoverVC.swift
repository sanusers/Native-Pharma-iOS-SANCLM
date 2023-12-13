

import UIKit

protocol PopOverVCDelegate: AnyObject {
    func didTapRow(_ index: Int, _ SelectedArrIndex: Int)
}


class PopOverVC: UIViewController {
    
    
    @IBOutlet weak var contentTable: UITableView!
    var delegate: PopOverVCDelegate?
    var strArr = [String]()
    var isExist = Bool()
    var isFromWishlist = Bool()
    var isFromHome = Bool()
    var selectedIndex = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        strArr = ["Edit", "Remove"]
        toLOadData()
    }
    
    func toLOadData() {
        contentTable.delegate = self
        contentTable.dataSource = self
        contentTable.reloadData()
    }
    
    //MARK:- initWithStory
    class func initWithStory(preferredFrame size : CGSize,on host : UIView) -> PopOverVC{
        let infoWindow: PopOverVC  = UIStoryboard(name: "Hassan", bundle: nil).instantiateViewController(withIdentifier: "PopOverVC") as! PopOverVC
          
        infoWindow.preferredContentSize = size
        infoWindow.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = infoWindow.popoverPresentationController!
        popover.delegate = infoWindow
        popover.sourceView = host
       // popover.backgroundColor = UIColor(hex: "ECF2FB")
        popover.permittedArrowDirections = UIPopoverArrowDirection.up
        
        
        return infoWindow
    }

    
}
extension PopOverVC : UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
extension UIViewController{
    func showPopOver(on host : UIView){
        let infoWindow = PopOverVC
            .initWithStory(preferredFrame: CGSize(width: self.view.frame.width,
                                                  height: 100),
                           on: host)
        infoWindow.modalPresentationStyle = .fullScreen
        self.present(infoWindow, animated: true) {
            infoWindow.toLOadData()
        }
    }
}




extension PopOverVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoTVC = tableView.dequeueReusableCell(withIdentifier: "InfoTVC", for: indexPath) as! InfoTVC
        cell.titleLbl.text = strArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.didTapRow(indexPath.row, self.selectedIndex)
        }

    }
    
    
}


class InfoTVC: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
