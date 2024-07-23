//
//  DCRapprovalinfoView.swift
//  SAN ZEN
//
//  Created by San eforce on 22/07/24.
//

import Foundation
import UIKit

extension DCRapprovalinfoView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
            return 7 + 1

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch section {
        case 0:
            return 1
        case 1:
            return  1
            //slidesResponseModel.count
        case 2:
            return   1
            //productStrArr.count
            
        case 3:
            return 1
            //inputStrArr.count
            
        case 4:
            return 1
           
            
        case 5:
            
            switch self.cellRCPAType {
            case .showRCPA:
                return  2
                //rcpaResponseModel.count
            case .hideRCPA:
                return 0
            }

            
        case 6:
            switch self.cellEventsType {
            case .showEvents:
                return 2
                //eventsResponseModel.count
            case .hideEvents:
                return 0
            }
        case 7:
            return 1
           
        default:
            return 0
        }
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.width, height: 160)
        case 1:
            return CGSize(width: collectionView.width, height: 40)
      
        case 2:
            return CGSize(width: collectionView.width, height: 40)
        case 3:
            return CGSize(width: collectionView.width, height: 40)
            
        case 4:
            return CGSize(width: collectionView.width, height: 40)
            
        case 5:
            return CGSize(width: collectionView.width, height: 40)
            
        case 6:
            switch indexPath.row {
            case 0:
                return  CGSize(width: collectionView.width, height: 40)
            default:
                return  CGSize(width: collectionView.width, height: 70)
                
            }
          //  return CGSize(width: collectionView.width, height: 40)

        case 7:
            return CGSize(width: collectionView.width, height: 100)
            
        default:
            return CGSize()
        }
        
        


    }

    
    func collectionView(_ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
            
          //
        case 1:
            switch kind {
            case UICollectionView.elementKindSectionHeader:

                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                  withReuseIdentifier: "\(DetailedSectionReusableView.self)",
                                  for: indexPath)  // Or simply withReuseIdentifier: "Item1HeaderView"
                headerView.backgroundColor = .clear
                guard let typedHeaderView = headerView as? DetailedSectionReusableView else { return headerView
                }

                return typedHeaderView
            default:
                print("No header")
            }
        case 2:
            switch kind {
            case UICollectionView.elementKindSectionHeader:

                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                  withReuseIdentifier: "\(ProductSectionReusableView.self)",
                                  for: indexPath)  // Or simply withReuseIdentifier: "Item1HeaderView"
                headerView.backgroundColor = .clear
                guard let typedHeaderView = headerView as? ProductSectionReusableView else { return headerView
                }

                return typedHeaderView
            default:
                print("No header")
            }
        case 3:
            switch kind {
            case UICollectionView.elementKindSectionHeader:

                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                  withReuseIdentifier: "\(InputSectionReusableView.self)",
                                  for: indexPath)  // Or simply withReuseIdentifier: "Item1HeaderView"
                headerView.backgroundColor = .clear
                guard let typedHeaderView = headerView as? InputSectionReusableView else { return headerView
                }

                return typedHeaderView
            default:
                print("No header")
            }
            
        case 4:
            switch kind {
            case UICollectionView.elementKindSectionHeader:

                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                  withReuseIdentifier: "\(SpecificDCRadditioanCallsinfoReusableView.self)",
                                  for: indexPath)  // Or simply withReuseIdentifier: "Item1HeaderView"
                headerView.backgroundColor = .clear
                guard let typedHeaderView = headerView as? SpecificDCRadditioanCallsinfoReusableView else { return headerView
                }

                return typedHeaderView
            default:
                print("No header")
            }
            
        case  5, 6:
     
            switch kind {
            case UICollectionView.elementKindSectionHeader:

                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                  withReuseIdentifier: "\(RCPASectionReusableView.self)",
                                  for: indexPath)  // Or simply withReuseIdentifier: "Item1HeaderView"
                headerView.backgroundColor = .clear
             
                guard let typedHeaderView = headerView as? RCPASectionReusableView else { return headerView
                }

                typedHeaderView.sectionHolderView.layer.borderWidth = 1
                typedHeaderView.sectionHolderView.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.1).cgColor
       
                switch indexPath.section {
                case 5:
                    typedHeaderView.sectionImage.image =  self.cellRCPAType == .hideRCPA ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
                    typedHeaderView.sectionTitle.text =  "RCPA"
                    typedHeaderView.addTap {
                        if self.cellRCPAType == .showRCPA {
                            self.cellRCPAType =  .hideRCPA
                            self.delegate?.didRCPAtapped(isrcpaTapped: false, index: self.selectedIndex ?? 0, responsecount: 0)
                            self.approvalDetailsCollection.reloadData()
                            return
                        }
                       // self.cellEventsType =  .hideEvents
                        self.cellRCPAType =  self.cellRCPAType == .showRCPA ?  .hideRCPA :  .showRCPA
                        self.delegate?.didRCPAtapped(isrcpaTapped: self.cellRCPAType == .showRCPA ? true :  false, index: self.selectedIndex ?? 0, responsecount: 1)
                        self.approvalDetailsCollection.reloadData()
                        
//                        self.makeRcpaApiCall()  {response in
//                            if response.isEmpty {
//                                self.toCreateToast("No RCPA found!")
//                                return
//                            }
//                            self.cellSlidesType =  .hideSlides
//                            self.cellRCPAType =  self.cellRCPAType == .showRCPA ?  .hideRCPA :  .showRCPA
//                            self.delegate?.didRCPAtapped(isrcpaTapped: self.cellRCPAType == .showRCPA ? true :  false, index: self.selectedIndex ?? 0, responsecount: response.count)
//                            self.extendedInfoCollection.reloadData()
//                         
//                        }
                    }
                case 6:
                    typedHeaderView.sectionImage.image =  self.cellEventsType == .hideEvents ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
                    typedHeaderView.sectionTitle.text =  "Captured Event"
                    typedHeaderView.addTap {
                        if self.cellEventsType == .showEvents {
                            self.cellEventsType =  .hideEvents
                            self.delegate?.didEventstapped(isEventstapped: false, index: self.selectedIndex ?? 0, response: [EventResponse()])
                            
                           // self.delegate?.didSlidestapped(isSlidestapped: false, index: self.selectedIndex ?? 0, responsecount: 0)
                            self.approvalDetailsCollection.reloadData()
                            return
                        }
                        
                        self.cellEventsType =  .showEvents
                       // self.cellRCPAType = .hideRCPA
                        self.delegate?.didEventstapped(isEventstapped: true, index: self.selectedIndex ?? 0, response: [EventResponse()])
                        self.approvalDetailsCollection.reloadData()
                        
//                        self.makeSlidesInfoApiCall()  { response in
//                            if response.isEmpty {
//                                self.toCreateToast("No slide info found!")
//                                return
//                            }
//                            self.cellEventsType =  .showEvents
//                            self.cellRCPAType = .hideRCPA
//                            self.delegate?.didEventstapped(isEventstapped: true, index: self.selectedIndex ?? 0, response: [EventResponse()])
//                            self.approvalDetailsCollection.reloadData()
//                         
//                        }
                    }
                default:
                    print("No header")
                }
            
            
                return typedHeaderView
            default:
                print("No header")
            }
            
        default:
            return UICollectionReusableView()
        }


      return UICollectionReusableView()
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Return the size of your header
        if section == 1  || section == 2 || section == 3 || section == 4  || section == 5 || section == 6   {
            return CGSize(width: collectionView.frame.width, height: 60)
        } else {
            return CGSize()
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: SpecificDCRgeneralinfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificDCRgeneralinfoCVC", for: indexPath) as! SpecificDCRgeneralinfoCVC
            //cell.typeIV.image = self.typeImage ?? UIImage()
            //cell.toPopulateCell(model: self.detailedReportModel ?? DetailedReportsModel())
            return cell
            //Yet to remove
        case 1:
            let cell: SpecificDCRslideinfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificDCRslideinfoCVC", for: indexPath) as! SpecificDCRslideinfoCVC
          // let model = self.slidesResponseModel[indexPath.row]
          //  cell.setupUI(currentRating: model.rating, selectedIndex: 0)
          //  cell.populateCell(model: model)
//            cell.infoView.addTap {
//              //  self.delegate?.didDurationInfoTapped(view: cell.infoView, startTime: model.startTime, endTime: model.endTime)
//            }
            return cell
        case 2:
            

                let cell: ProductsDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsDescriptionCVC", for: indexPath) as! ProductsDescriptionCVC
               // let modelStr = self.productStrArr[indexPath.row]

              //  cell.topopulateCell(modelStr: modelStr)
                
                return cell
            
        case 3:
            

                let cell: InputDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "InputDescriptionCVC", for: indexPath) as! InputDescriptionCVC
              //  let modelStr = self.inputStrArr[indexPath.row]

             //   cell.topopulateCell(modelStr: modelStr)
                
                return cell
       
        case 4:
                let cell: ProductsDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsDescriptionCVC", for: indexPath) as! ProductsDescriptionCVC
             //   let modelStr = self.productStrArr[indexPath.row]

             //   cell.topopulateCell(modelStr: modelStr)
                
                return cell
            
        case 5:
            switch self.cellRCPAType {
            case .showRCPA:
                switch indexPath.row {
                case 0:
                    let cell: RCPAdetailsInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "RCPAdetailsInfoCVC", for: indexPath) as! RCPAdetailsInfoCVC
                    return cell
                default:
                    let cell: RCPAdetailsDesctiptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "RCPAdetailsDesctiptionCVC", for: indexPath) as! RCPAdetailsDesctiptionCVC
                  //  let model = rcpaResponseModel[indexPath.row]
                  //  cell.populateCell(model: model)
                    cell.infoView.addTap {
                   //     self.delegate?.didRCPAinfoTapped(view: cell.infoView, model: model)
                    }
                    return cell
                }
            case .hideRCPA:
                return UICollectionViewCell()
            }

          //  SlidesDescriptionCVC
        case 6:
            switch self.cellEventsType {
            case .showEvents:
                switch indexPath.row {
                case 0:
                    let cell: SpecificDCReventsInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificDCReventsInfoCVC", for: indexPath) as! SpecificDCReventsInfoCVC
                    cell.contentHolderView.layer.cornerRadius = 5
                    cell.contentHolderView.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
                    return cell
                default:
                    let cell: SpecificDCReventsDescCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificDCReventsDescCVC", for: indexPath) as! SpecificDCReventsDescCVC
                    cell.eventIV.layer.cornerRadius = 3
                    cell.eventIV.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
                    return cell
                }
            case .hideEvents:
                return UICollectionViewCell()
            }
        case 7:
            let cell: SpecificDCRremarksCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificDCRremarksCVC", for: indexPath) as! SpecificDCRremarksCVC
           // cell.remarksDesc.text = detailedReportModel?.remarks
            return cell
            
        default:
           return UICollectionViewCell()
        }
    }
    
    
}


 
class DCRapprovalinfoView : BaseView {
    
    
    @IBOutlet var approvalTitle: UILabel!
    
    @IBOutlet weak var topNavigationView: UIView!
    
    
    @IBOutlet weak var collectionHolderView: UIView!
    
    @IBOutlet weak var backHolderView: UIView!
    
    
    @IBOutlet weak var approvalDetailsCollection: UICollectionView!
    
    
    @IBOutlet weak var approvalTable: UITableView!
    
    
    @IBOutlet var searchHolderView: UIView!
    
    @IBOutlet var dismissVIew: UIView!
    
    //@IBOutlet var approveView: UIView!
    var typeImage : UIImage?
    weak var delegate: ViewAllInfoTVCDelegate?
    var reportModel: ReportsModel?
    var reportsVM: ReportsVM?
    var detailedReportModel: DetailedReportsModel?
    var selectedIndex : Int? = nil
    var cellEventsType: cellEventsType = .hideEvents
    var cellSlidesType: CellSlidesType = .hideSlides
    var cellRCPAType: CellRCPAType = .hideRCPA
    var isTohideLocationInfo = false
    var dcrApprovalinfoVC : DCRapprovalinfoVC!
    var slidesResponseModel : [SlideDetailsResponse] = []
    var rcpaResponseModel : [RCPAresonseModel] = []
    var eventsResponseModel : [EventResponse] = []
    var ResponseModel : [EventResponse] = []
    var productStrArr : [SampleProduct] = []
    
    var inputStrArr: [SampleInput] = []
    var selectedBrandsIndex: Int = 0
    var selectedType: CellType = .Doctor
    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.dcrApprovalinfoVC = baseVC as? DCRapprovalinfoVC
        initTaps()
        setupUI()
        cellregistration()
        loadApprovalTable()
      
    }
    
    func setupUI() {
        self.backgroundColor = .appSelectionColor
        collectionHolderView.layer.cornerRadius = 5
        searchHolderView.layer.cornerRadius = 5
        dismissVIew.layer.cornerRadius = 5
      
        dismissVIew.backgroundColor = .appLightTextColor.withAlphaComponent(0.2)
        dismissVIew.layer.borderWidth = 1
        dismissVIew.layer.borderColor = UIColor.appTextColor.withAlphaComponent(0.2).cgColor
    }
    
    func loadApprovalTable() {
        approvalTable.delegate = self
        approvalTable.dataSource = self
        approvalTable.reloadData()
    }
    
    func loadApprovalDetailCollection() {
        approvalDetailsCollection.delegate = self
        approvalDetailsCollection.dataSource = self
        approvalDetailsCollection.reloadData()
    }
    
    func cellregistration() {
        approvalTable.register(UINib(nibName: "DCRApprovalsTVC", bundle: nil), forCellReuseIdentifier: "DCRApprovalsTVC")
        

//        approvalDetailsCollection.register(UINib(nibName: "VisitInfoCVC", bundle: nil), forCellWithReuseIdentifier: "VisitInfoCVC")
                approvalDetailsCollection.register(UINib(nibName: "SpecificDCRgeneralinfoCVC", bundle: nil), forCellWithReuseIdentifier: "SpecificDCRgeneralinfoCVC")
        
        approvalDetailsCollection.register(UINib(nibName: "SpecificDCRslideinfoCVC", bundle: nil), forCellWithReuseIdentifier: "SpecificDCRslideinfoCVC")
        
        approvalDetailsCollection.register(UINib(nibName: "SpecificDCReventsDescCVC", bundle: nil), forCellWithReuseIdentifier: "SpecificDCReventsDescCVC")
        

//        extendedInfoCollection.register(UINib(nibName: "ProductSectionTitleCVC", bundle: nil), forCellWithReuseIdentifier: "ProductSectionTitleCVC")
        approvalDetailsCollection.register(UINib(nibName: "rcpaCVC", bundle: nil), forCellWithReuseIdentifier: "rcpaCVC")
        
        approvalDetailsCollection.register(UINib(nibName: "SpecificDCRremarksCVC", bundle: nil), forCellWithReuseIdentifier: "SpecificDCRremarksCVC")

        
        approvalDetailsCollection.register(UINib(nibName: "ProductsDescriptionCVC", bundle: nil), forCellWithReuseIdentifier: "ProductsDescriptionCVC")
        
        approvalDetailsCollection.register(UINib(nibName: "InputDescriptionCVC", bundle: nil), forCellWithReuseIdentifier: "InputDescriptionCVC")
        
        
        approvalDetailsCollection.register(UINib(nibName: "RCPAsectionHeader", bundle: nil), forCellWithReuseIdentifier: "RCPAsectionHeader")
        
        
        approvalDetailsCollection.register(UINib(nibName: "RCPAdetailsDesctiptionCVC", bundle: nil), forCellWithReuseIdentifier: "RCPAdetailsDesctiptionCVC")
        
        approvalDetailsCollection.register(UINib(nibName: "RCPAdetailsInfoCVC", bundle: nil), forCellWithReuseIdentifier: "RCPAdetailsInfoCVC")
        
        approvalDetailsCollection.register(UINib(nibName: "SlidesInfoCVC", bundle: nil), forCellWithReuseIdentifier: "SlidesInfoCVC")
        
        approvalDetailsCollection.register(UINib(nibName: "SpecificDCReventsInfoCVC", bundle: nil), forCellWithReuseIdentifier: "SpecificDCReventsInfoCVC")
        
        
        
        
        approvalDetailsCollection.register(RCPASectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RCPASectionReusableView")
        
        approvalDetailsCollection.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
        
        
        
        
        approvalDetailsCollection.register(SpecificDCRadditioanCallsinfoReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SpecificDCRadditioanCallsinfoReusableView")
        
        approvalDetailsCollection.register(DetailedSectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailedSectionReusableView")
        
        approvalDetailsCollection.register(ProductSectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductSectionReusableView")
        
        approvalDetailsCollection.register(InputSectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "InputSectionReusableView")
        
    }

    
    func initTaps() {
        backHolderView.addTap {
            self.dcrApprovalinfoVC.navigationController?.popViewController(animated: true)
        }
        
        dismissVIew.addTap {
            self.dcrApprovalinfoVC.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension DCRapprovalinfoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return 10


    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return tableView.height / 11

        
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell: DCRApprovalsTVC = approvalTable.dequeueReusableCell(withIdentifier: "DCRApprovalsTVC", for: indexPath) as! DCRApprovalsTVC
            cell.selectionStyle = .none
            cell.approcalDateLbl.textColor = .appTextColor
            cell.mrNameLbl.textColor = .appTextColor
            cell.contentHolderView.backgroundColor = .appWhiteColor
            cell.contentHolderView.layer.cornerRadius = 5
            cell.accessoryIV.image = UIImage(named: "chevlon.right")
            cell.accessoryIV.tintColor = .appTextColor
            cell.dateHolderView.isHidden = true
            
            if selectedBrandsIndex == indexPath.row {
                cell.contentHolderView.backgroundColor = .appTextColor
                cell.mrNameLbl.textColor = .appWhiteColor
                cell.accessoryIV.tintColor = .appWhiteColor
            }
            
            cell.addTap {[weak self] in
                guard let welf = self else {return}
                welf.selectedBrandsIndex = indexPath.row
                welf.approvalTable.reloadData()
              //  welf.approvalCollection.reloadData()
                welf.loadApprovalDetailCollection()
            }
            
     return cell

    }
    
    
}
