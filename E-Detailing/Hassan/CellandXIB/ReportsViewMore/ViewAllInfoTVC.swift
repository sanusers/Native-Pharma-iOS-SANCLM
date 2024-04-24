//
//  ViewAllInfoTVC.swift
//  E-Detailing
//
//  Created by Hassan
//
//  Copyright © 2024 san eforce. All rights reserved. 23/12/23.
//

import UIKit

extension ViewAllInfoTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        switch self.cellType {
            
        case .showRCPA:
           
            //MARK: - rcpa cell (+1 section)
            return 8
        case .hideRCPA:
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch section {
        case 1:
            if self.isTohideLocationInfo {
                return 0
            } else {
                return 1
            }
        case 2:
            return  productStrArr.count
            
        case 3:
            return inputStrArr.count
            
        case 4:
            return 1
            
            
            
        default:
            switch self.cellType {
                
            case .showRCPA:
                switch section {
                    //MARK: - rcpa cell (+1 section)
                case 4:
                    return 3
                default:
                    return 1
                }
            case .hideRCPA:
                switch section {
                default:
                    return 1
                }
            }
        }
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.width, height: 190)
            
            
        case 1:
            return CGSize(width: collectionView.width, height: 100)
      
        case 2:
            return CGSize(width: collectionView.width, height: 40)
        case 3:
            return CGSize(width: collectionView.width, height: 40)
            
        case 4:
            return CGSize(width: collectionView.width, height: 60)
        default:
            switch self.cellType {
                
            case .showRCPA:
                switch indexPath.section {

                    
                    //MARK: - rcpa cell (+1 section)
                case 5:
                    return CGSize(width: collectionView.width, height: 40)
                    
                case 6:
                    return CGSize(width: collectionView.width, height: 75)
                case 7:
                    return CGSize(width: collectionView.width, height: 50)
                default:
                    return CGSize()
                }
            case .hideRCPA:
                switch indexPath.section {
                case 5:
                    return CGSize(width: collectionView.width, height: 75)
                case 6:
                    return CGSize(width: collectionView.width, height: 50)
                default:
                    return CGSize()
                }
            }
        }
        
        


    }

    
    func collectionView(_ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
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
        default:
            return UICollectionReusableView()
        }


      return UICollectionReusableView()
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Return the size of your header
        if section == 2 || section == 3   {
            return CGSize(width: collectionView.frame.width, height: 70)
        } else {
            return CGSize()
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: VisitInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "VisitInfoCVC", for: indexPath) as! VisitInfoCVC
            cell.typeIV.image = self.typeImage ?? UIImage()
            cell.toPopulateCell(model: self.detailedReportModel ?? DetailedReportsModel())
            return cell
            
        case 1:
            let cell: TimeInfoCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeInfoCVC", for: indexPath) as! TimeInfoCVC
            cell.toPopulateCell(model: self.reportModel ?? ReportsModel())
            return cell
        case 2:
            

                let cell: ProductsDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsDescriptionCVC", for: indexPath) as! ProductsDescriptionCVC
                let modelStr = self.productStrArr[indexPath.row]

                cell.topopulateCell(modelStr: modelStr)
                
                return cell
            
        case 3:
            

                let cell: InputDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "InputDescriptionCVC", for: indexPath) as! InputDescriptionCVC
                let modelStr = self.inputStrArr[indexPath.row]

                cell.topopulateCell(modelStr: modelStr)
                
                return cell
            

        case 4:
            let cell: rcpaCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "rcpaCVC", for: indexPath) as! rcpaCVC
            cell.addTap {
                self.cellType =   self.cellType == .showRCPA ?  .hideRCPA : .showRCPA
                self.delegate?.didLessTapped(islessTapped: false, isrcpaTapped: self.cellType  == .hideRCPA ?  false : true, index: self.selectedIndex ?? 0)
                //self.cellType == .showRCPA ? true : false
                self.extendedInfoCollection.reloadData()
            }
            return cell
        default:
            switch self.cellType {
                
            case .showRCPA:
                switch indexPath.section {
                    //MARK: - rcpa cell (+1 section)
                case 5:

                        let cell: ProductsDescriptionCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsDescriptionCVC", for: indexPath) as! ProductsDescriptionCVC
                        cell.topopulateCell(modelStr: SampleProduct(prodName: "-", isPromoted: false, noOfSamples: "-", rxQTY: "-", rcpa: "-", isDemoProductCell: true))
                        return cell
         
                case 6:
                    let cell: ReportsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCVC", for: indexPath) as! ReportsCVC
                    return cell
                    
                    
                case 7:
                    let cell: ViewmoreCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewmoreCVC", for: indexPath) as! ViewmoreCVC
                    cell.addTap {
                        
                        self.delegate?.didLessTapped(islessTapped: true, isrcpaTapped: false, index: self.selectedIndex ?? 0)
                    }
                    return cell
                    
                default:
                    return UICollectionViewCell()
                }
            case .hideRCPA:
                switch indexPath.section {
                case 5:
                    let cell: ReportsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCVC", for: indexPath) as! ReportsCVC
                    cell.remarksDesc.text =  self.reportModel?.remarks ?? "-"
                    return cell
                case 6:
                    let cell: ViewmoreCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewmoreCVC", for: indexPath) as! ViewmoreCVC
                    cell.addTap {
                        
                        self.delegate?.didLessTapped(islessTapped: true, isrcpaTapped: false, index: self.selectedIndex ?? 0)
                    }
                    return cell
                    
                default:
                    return UICollectionViewCell()
                }
            }
        }
        

        
    }
    
    
}

protocol ViewAllInfoTVCDelegate: AnyObject {
    func didLessTapped(islessTapped: Bool, isrcpaTapped: Bool, index: Int)
        
    
}

struct SampleProduct {
    let prodName: String
    let isPromoted: Bool?
    let noOfSamples : String
    let rxQTY: String
    let rcpa: String
    let isDemoProductCell: Bool
}

struct SampleInput {
    let prodName: String
    let noOfSamples : String
}

class ViewAllInfoTVC: UITableViewCell {
    
    enum CellType {
        case showRCPA
        case hideRCPA
    }
    
    
    
    
    @IBOutlet var extendedInfoCollection: UICollectionView!
    weak var delegate: ViewAllInfoTVCDelegate?
    var rcpaTapped: Bool = false
    //var selectedType: CellType = .All
    var cellType: CellType = .hideRCPA
    var reportModel: ReportsModel?
    var detailedReportModel: DetailedReportsModel?
    var productStrArr : [SampleProduct] = []
    var inputStrArr: [SampleInput] = []
    var typeImage: UIImage?
    var isTohideLocationInfo = false
    var selectedIndex : Int? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        extendedInfoCollection.elevate(4)
        extendedInfoCollection.layer.cornerRadius = 5
        extendedInfoCollection.isScrollEnabled = false
        cellRegistration()
        // toLoadData()
    }
    
    func hideLocationSection() {
        if reportModel?.intime == "" &&  reportModel?.outtime == "" &&  reportModel?.inaddress == "" && reportModel?.outaddress == "" {
            isTohideLocationInfo = true
        }
    }
    
    func toSetDataSourceForInputs()   {
        inputStrArr.removeAll()
        //detailedReportModel?.gifts
        if detailedReportModel?.gifts != "" {
            var inputArr =  detailedReportModel?.gifts.components(separatedBy: ",")
            
            inputArr?.removeLast()
            
            let filteredComponents = inputArr?.map { anElement -> String in
                var modifiedElement = anElement
                if modifiedElement.first == " " {
                    modifiedElement.removeFirst()
                }
                return modifiedElement
            }
            filteredComponents?.forEach { prod in
                var prodString : [String] = []
                prodString.append(contentsOf: prod.components(separatedBy: "("))
                prodString = prodString.map({ aprod in
                    aprod.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
                })
                var name: String = ""
            
                var noOfsamples: String = ""

                prodString.enumerated().forEach {prodindex, prod in
              
                   // let sampleProduct: SampleProduct
                    switch prodindex {
                    case 0 :
                        name = prod
                    case 1:
                        noOfsamples = prod
                    default:
                        print("default")
                    }
                }
                
         
                
                
                let aInput = SampleInput(prodName: name, noOfSamples: noOfsamples)

                self.inputStrArr.append(aInput)
            }

        } else {
            inputStrArr.append(SampleInput(prodName: "-", noOfSamples: "-"))
        }
            
            
    }
    
    func toSetDataSourceForProducts() {
        productStrArr.removeAll()
     //   productStrArr.append(SampleProduct(prodName: "", isPromoted: false, noOfSamples: "", rxQTY: "", rcpa: "", isDemoProductCell: true))
        
       if detailedReportModel?.products != "" {
           var prodArr =  detailedReportModel?.products.components(separatedBy: ",")
     
               prodArr?.removeLast()
      
           
           let filteredComponents = prodArr?.map { anElement -> String in
               var modifiedElement = anElement
               if modifiedElement.first == " " {
                   modifiedElement.removeFirst()
               }
               return modifiedElement
           }
           
           filteredComponents?.forEach { prod in
               var prodString : [String] = []
               prodString.append(contentsOf: prod.components(separatedBy: "("))
               prodString = prodString.map({ aprod in
                   aprod.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
               })
               var name: String = ""
               var isPromoted: Bool = false
               var noOfsamples: String = ""
               var rxQty: String = ""
               var rcpa: String  = ""
               prodString.enumerated().forEach {prodindex, prod in
             
                  // let sampleProduct: SampleProduct
                   switch prodindex {
                   case 0 :
                       name = prod
                   case 1:
                       noOfsamples = prod
                   case 2:
                       rxQty = prod
                   case 3:
                       if let index = prod.firstIndex(of: "^") {
                           let startIndex = prod.index(after: index)
                           let numberString = String(prod[startIndex...])
                           rcpa = numberString
                           print(numberString) // This will print "5"
                       } else {
                           print("'^' not found in the expression.")
                           rcpa = "-"
                       }
                      
   
                   default:
                       print("default")
                   }
               }
               
        
               let promotdProduct = self.detailedReportModel?.promotedProducts
               guard let promotdProduct = promotdProduct, promotdProduct != "" else {
                   return}
      
               // Split the promotedProduct string by the "$" delimiter
               let components = promotdProduct.components(separatedBy: "$")

               // Process each component to remove "#" character
               let namesWithoutHash = components.map { $0.replacingOccurrences(of: "#", with: "") }

               // Extract words after the "$" sign and flatten the resulting array
               let words = namesWithoutHash.flatMap { $0.components(separatedBy: " ") }

               // Check if any of the extracted words matches the name
               if words.contains(where: { $0 == name.components(separatedBy: " ").first }) {
                   print("The 'promotedProduct' contains '\(name)'")
                   isPromoted = true
               } else {
                   print("The 'promotedProduct' does not contain '\(name)'")
                   isPromoted = false
               }
               
               
               let aProduct = SampleProduct(prodName: name, isPromoted: isPromoted, noOfSamples: noOfsamples, rxQTY: rxQty, rcpa: rcpa, isDemoProductCell: false)
               
             //  let aProduct = SampleProduct(prodName: prodString[0].isEmpty ? "" : prodString[0] , isPromoted: prodString[1].isEmpty ? false : prodString[1].contains("0") ? true : false, noOfSamples:  prodString[2].isEmpty ? "" : prodString[2] , rxQTY:  prodString[3].isEmpty ? "" : prodString[3] , rcpa:  prodString[4].isEmpty ? "" : prodString[4])
               productStrArr.append(aProduct)
           }
       } else {
           productStrArr.append(SampleProduct(prodName: "-", isPromoted: nil, noOfSamples: "-", rxQTY: "-", rcpa: "-", isDemoProductCell: true))
       }

        
        //productStrArr.append(contentsOf: detailedReportModel?.products.components(separatedBy: ",") ?? [])
  
        
        
         
    }
    
    func toLoadData() {
        extendedInfoCollection.delegate = self
        extendedInfoCollection.dataSource = self
        extendedInfoCollection.reloadData()
    }
    
    func cellRegistration() {
        
        extendedInfoCollection.register(UINib(nibName: "VisitInfoCVC", bundle: nil), forCellWithReuseIdentifier: "VisitInfoCVC")
        extendedInfoCollection.register(UINib(nibName: "TimeInfoCVC", bundle: nil), forCellWithReuseIdentifier: "TimeInfoCVC")
//        extendedInfoCollection.register(UINib(nibName: "ProductSectionTitleCVC", bundle: nil), forCellWithReuseIdentifier: "ProductSectionTitleCVC")
        extendedInfoCollection.register(UINib(nibName: "rcpaCVC", bundle: nil), forCellWithReuseIdentifier: "rcpaCVC")
        extendedInfoCollection.register(UINib(nibName: "ReportsCVC", bundle: nil), forCellWithReuseIdentifier: "ReportsCVC")
        extendedInfoCollection.register(UINib(nibName: "ViewmoreCVC", bundle: nil), forCellWithReuseIdentifier: "ViewmoreCVC")
        
        extendedInfoCollection.register(UINib(nibName: "ProductsDescriptionCVC", bundle: nil), forCellWithReuseIdentifier: "ProductsDescriptionCVC")
        
        extendedInfoCollection.register(UINib(nibName: "InputDescriptionCVC", bundle: nil), forCellWithReuseIdentifier: "InputDescriptionCVC")
        
        
        extendedInfoCollection.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
        
        extendedInfoCollection.register(ProductSectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductSectionReusableView")
        
        extendedInfoCollection.register(InputSectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "InputSectionReusableView")
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
