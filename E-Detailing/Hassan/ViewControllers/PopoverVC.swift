

import UIKit

protocol PopOverVCDelegate: AnyObject {
    func didTapRow(_ index: Int, _ SelectedArrIndex: Int)
}


class PopOverVC: UIViewController {
    
    
    enum PageType {
        case TP
        case HomeGraph
        case calls
        case presentation
    }
    
    
    func toSetPageType(_ pageType: PageType) {
        contentTable.showsVerticalScrollIndicator = false
        contentTable.showsHorizontalScrollIndicator = false
        switch pageType {
            
        case .TP:
            self.contentTable.isHidden = false
            graphInfoView.isHidden = true
            toLOadData()
        case .HomeGraph:
            self.contentTable.isHidden = true
            graphInfoView.isHidden = false
            setupUI()
            
        case .calls:
            self.contentTable.isHidden = false
            graphInfoView.isHidden = true
            toLOadData()
        case .presentation:
            self.contentTable.isHidden = false
            graphInfoView.isHidden = true
            toLOadData()
        }
    }
    
    @IBOutlet var graphInfoView: UIView!
    
    @IBOutlet weak var contentTable: UITableView!
    
    @IBOutlet var callCountLbl: UILabel!
    @IBOutlet var totalCallsLbl: UILabel!
    
    @IBOutlet var avgCllLbl: UILabel!
    
    @IBOutlet var avgCallCount: UILabel!
    var delegate: PopOverVCDelegate?
    var strArr = [String]()
    var isExist = Bool()
    var isFromWishlist = Bool()
    var isFromHome = Bool()
    var selectedIndex = Int()
    var pageType: PageType = .TP
    var totalCalls: Int = 0
    var avgCalls: Int = 0
    var color : UIColor? = .appGreen
    override func viewDidLoad() {
        super.viewDidLoad()
       
        toSetPageType(self.pageType)
    }

    
    
    func setupUI() {
        
        graphInfoView.backgroundColor = color
        graphInfoView.layer.cornerRadius = 5
        
        
        let infoLbls = [callCountLbl, totalCallsLbl, avgCllLbl, avgCallCount]
        
        infoLbls.forEach { lbl in
            
            if lbl == totalCallsLbl || lbl == avgCllLbl {
                lbl?.setFont(font: .bold(size: .BODY))
            } else {
                lbl?.setFont(font: .medium(size: .BODY))
                
            }
            
            lbl?.textColor = .appWhiteColor
            
        }
        callCountLbl.text = "\(self.avgCalls)"
        avgCallCount.text =  "\(self.totalCalls)"
    }
    
    func toLOadData() {
        strArr = pageType == .TP ? ["Edit"] : pageType == .calls ? ["Edit", "Delete"] : ["Play", "Edit", "Delete"]
        contentTable.delegate = self
        contentTable.dataSource = self
        contentTable.reloadData()
    }
    
    //MARK:- initWithStory
    class func initWithStory(preferredFrame size : CGSize,on host : UIView, onframe hostframe: CGRect, pagetype: PageType) -> PopOverVC{
        let infoWindow: PopOverVC  = UIStoryboard(name: "Hassan", bundle: nil).instantiateViewController(withIdentifier: "PopOverVC") as! PopOverVC
        infoWindow.pageType = pagetype
        infoWindow.preferredContentSize = size
        infoWindow.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = infoWindow.popoverPresentationController!
        popover.delegate = infoWindow
        if pagetype == .HomeGraph {
            //popover.sourceRect = hostframe
            popover.sourceView = host
        } else {
            popover.sourceView = host
        }
    
     
        popover.backgroundColor = .appGreen
        popover.permittedArrowDirections = pagetype == .calls ? UIPopoverArrowDirection.up : pagetype == .presentation ?  UIPopoverArrowDirection.up :  UIPopoverArrowDirection.down
        
        
        return infoWindow
    }

    
}
extension PopOverVC : UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
extension UIViewController{
//    func showPopOver(on host : UIView, isForTP: Bool){
//        let infoWindow = PopOverVC
//            .initWithStory(preferredFrame: CGSize(width: self.view.frame.width,
//                                                  height: 100),
//                           on: host, pagetype: isForTP ? .TP : .HomeGraph)
//        infoWindow.modalPresentationStyle = .fullScreen
//        self.present(infoWindow, animated: true) {
//        //    infoWindow.toLOadData()
//        }
//    }
}




extension PopOverVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoTVC = tableView.dequeueReusableCell(withIdentifier: "InfoTVC", for: indexPath) as! InfoTVC
        cell.titleLbl.text = strArr[indexPath.row]
        cell.titleLbl.textColor = .appTextColor
        cell.titleLbl.setFont(font: .bold(size: .BODY))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.didTapRow(indexPath.row, self.selectedIndex)
            self.delegate = nil
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch self.pageType {

        case .TP:
            return 40
        case .HomeGraph:
            return UITableView.automaticDimension
        case .calls:
            return 40
        case .presentation:
            return 40
        }
        
   
    }
    
    
}


class InfoTVC: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
