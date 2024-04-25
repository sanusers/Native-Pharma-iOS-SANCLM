//
//  DetailedSlideInfoView.swift
//  E-Detailing
//
//  Created by San eforce on 25/04/24.
//

import Foundation
import UIKit

extension DetailedSlideInfoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shared.instance.detailedSlides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailedInfoTVC = tableView.dequeueReusableCell(withIdentifier: "DetailedInfoTVC", for: indexPath) as! DetailedInfoTVC
        let model =  Shared.instance.detailedSlides[indexPath.row]
        let idStr =  model.slideID ?? Int()
        cell.brandName.text = "\(idStr)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = detailedInfoTable.dequeueReusableHeaderFooterView(withIdentifier: "DetailedInfoHeader") as? DetailedInfoHeader else {
 
            return UIView()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height / 10
    }
    
    
}
 
class DetailedSlideInfoView: UIView {
    
    @IBOutlet var detailedInfoTable: UITableView!
    var detailedSlideInfoModal: [DetailedSlideInfoModal] = []
    func setupui() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        cellRegistration()
        toLoadData()
       // toSetDataSorce()
       
    }
    
    
    struct DetailedSlideInfoModal {
        var brandName: Int?
    }
    
    func toSetDataSorce() {
        
        
        
       let groupedSlides = CoreDataManager.shared.retriveGroupedSlides()
        groupedSlides.forEach { aGroupedBrandsSlideModel in
            aGroupedBrandsSlideModel.groupedSlide.forEach { aSlidesModel in
                if Shared.instance.detailedSlides.contains(where: { aDetailedSlide in
                    aDetailedSlide.slideID == aSlidesModel.slideId
                }) {
                    let aDetailedSlideInfoModal = DetailedSlideInfoModal(brandName: aGroupedBrandsSlideModel.productBrdCode)
                    detailedSlideInfoModal.append(aDetailedSlideInfoModal)
                }
                    
            }
        }
        
        
        dump(detailedSlideInfoModal)
    }
    
    func toLoadData() {
        detailedInfoTable.delegate = self
        detailedInfoTable.dataSource = self
        detailedInfoTable.reloadData()
    }
    
    func cellRegistration() {
        self.detailedInfoTable.register(UINib(nibName: "DetailedInfoHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailedInfoHeader")
        self.detailedInfoTable.register(UINib(nibName: "DetailedInfoTVC", bundle: nil), forCellReuseIdentifier: "DetailedInfoTVC")
        
    }
    
}
