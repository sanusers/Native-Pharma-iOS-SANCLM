//
//  HomeCheckinDetailsView.swift
//  E-Detailing
//
//  Created by San eforce on 28/02/24.
//

import Foundation
import UIKit
class HomeCheckinDetailsView: UIView {
 
    @IBOutlet var lblCheckin: UILabel!
    
    @IBOutlet var dateTimeinfoLbl: UILabel!
    
    @IBOutlet var locationLbl: UILabel!
    
    @IBOutlet var latitudeLbl: UILabel!
    @IBOutlet var longitudeLbl: UILabel!
    
    @IBOutlet var addressLbl: UILabel!
    
    @IBOutlet var localityDesc1: UILabel!
    
    @IBOutlet var localityDesc2: UILabel!
    
    
    @IBOutlet var closeBtn: ShadowButton!
    
    var delegate: addedSubViewsDelegate?
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        
        delegate?.didClose()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 5
        lblCheckin.setFont(font: .bold(size: .BODY))
        locationLbl.setFont(font: .bold(size: .BODY))
        addressLbl.setFont(font: .bold(size: .BODY))
        dateTimeinfoLbl.setFont(font: .medium(size: .BODY))
        latitudeLbl.setFont(font: .medium(size: .BODY))
        longitudeLbl.setFont(font: .medium(size: .BODY))
        localityDesc1.setFont(font: .medium(size: .BODY))
        localityDesc2.setFont(font: .medium(size: .BODY))
        
        retriveCheckinInfo()
    }
    
    func retriveCheckinInfo() {
        CoreDataManager.shared.fetchCheckininfo() { saveCheckins  in
            guard let aCheckin = saveCheckins.first else {return}
            dateTimeinfoLbl.text = aCheckin.checkinDateTime
            latitudeLbl.text = "\(aCheckin.latitude),"
            longitudeLbl.text = "\(aCheckin.longitude)"
          
    
            let addressArray = aCheckin.address?.components(separatedBy: ", ")

            if let addressArray = addressArray, addressArray.count >= 4 {
                // Extract the first three components
                let locality1 = addressArray[0]
                let locality2 = addressArray[1]
                let locality3 = addressArray[2]

                // Combine the remaining components into the fourth and fifth components
                let locality4 = addressArray[3...].joined(separator: ", ")

                localityDesc1.text = "\(locality1), \(locality2),"
                localityDesc2.text = "\(locality3), \(locality4)"
            } else {
                // Handle the case where the address does not have enough components
                print("Invalid address format")
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      

    }
    
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
       
     }
    
}
