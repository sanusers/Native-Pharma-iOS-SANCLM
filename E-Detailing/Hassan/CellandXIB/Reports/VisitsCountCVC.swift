//
//  VisitsCountCVC.swift
//  E-Detailing
//
//  Created by San eforce on 22/12/23.
//

import UIKit


enum CellType: String {
    case All
    case Doctor
    case Chemist
    case Stockist
    case Hospital
    case CIP
    
    var coclor: UIColor {
        switch self {
            
        case .All:
            return .appTextColor
        case .Doctor:
            return .appGreen
        case .Chemist:
            return .appBlue
        case .Stockist:
            return .appLightPink
        case .Hospital:
            return .appBrown
        case .CIP:
            return .calenderMarkerColor
        }
    }
    
    var text: String {
        switch self {
            
        default:
            return self.rawValue
        }
    }
    
}

class VisitsCountCVC: UICollectionViewCell {

    

    @IBOutlet var visualBlurView: UIVisualEffectView!
    
    @IBOutlet var holderView: UIView!
    
    @IBOutlet var typesLbl: UILabel!
    @IBOutlet var countsLbl: UILabel!
    @IBOutlet var contsView: UIView!
    var type: CellType = .Doctor
    var selectedIndex: Int? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func toPopulatecell() {
        holderView.layer.cornerRadius = 5
        contsView.layer.cornerRadius = contsView.height / 2
        countsLbl.setFont(font: .medium(size: .BODY))
        countsLbl.textColor = .appWhiteColor
        typesLbl.setFont(font: .medium(size: .BODY))
        holderView.layer.cornerRadius = 4
        switch self.type {
            
        case .All:
            visualBlurView.backgroundColor = type.coclor
            contsView.backgroundColor = type.coclor
            typesLbl.text = type.text
        case .Doctor:
            visualBlurView.backgroundColor = type.coclor
            contsView.backgroundColor = type.coclor
            typesLbl.text = type.text
        case .Chemist:
            visualBlurView.backgroundColor = type.coclor
            contsView.backgroundColor = type.coclor
            typesLbl.text = type.text
        case .Stockist:
            visualBlurView.backgroundColor = type.coclor
            contsView.backgroundColor = type.coclor
            typesLbl.text = type.text
        case .Hospital:
            visualBlurView.backgroundColor = type.coclor
            contsView.backgroundColor = type.coclor
            typesLbl.text = type.text
        case .CIP:
            visualBlurView.backgroundColor = type.coclor
            contsView.backgroundColor = type.coclor
            typesLbl.text = type.text
        }
        
    }

}
