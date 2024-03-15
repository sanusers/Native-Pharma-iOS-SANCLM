//
//  PreCallVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 08/08/23.
//

import Foundation
import UIKit

extension PreCallVC : collectionViewProtocols {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PreviewTypeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewTypeCVC", for: indexPath) as! PreviewTypeCVC
        
        
        cell.selectionView.isHidden =  selectedSegmentsIndex == indexPath.row ? false : true
        cell.titleLbl.textColor =  selectedSegmentsIndex == indexPath.row ? .appTextColor : .appLightTextColor
        cell.titleLbl.text = segmentType[indexPath.row].rawValue
        
        
        
        
        cell.addTap { [weak self] in
            guard let welf = self else {return}
            welf.selectedSegmentsIndex  = indexPath.row
            
            welf.segmentsCollection.reloadData()
            
            
            switch welf.segmentType[welf.selectedSegmentsIndex] {
                
            case .Overview:
                
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
                
            case .Precall :
                
                welf.setSegment(welf.segmentType[welf.selectedSegmentsIndex])
                
            }
            
            
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

  
             return CGSize(width:segmentType[indexPath.item].rawValue.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: collectionView.height)
         //   return CGSize(width: collectionView.width / 2, height: collectionView.height)
        
    }
}

class PreCallVC : UIViewController {
    
    enum SegmentType : String {
        case Overview = "Overview"
        case Precall = "Pre call Analysis"

    }
    func setSegment(_ segmentType: SegmentType, isfromSwipe: Bool? = false) {
        switch segmentType {
            
        case .Overview:
            self.selectedSegmentsIndex = 0
            self.segmentsCollection.reloadData()
        case .Precall:
            self.selectedSegmentsIndex = 1
            self.segmentsCollection.reloadData()
        }
    }
    
    func toLoadSegments() {
        segmentType = [.Overview , .Precall]
        self.segmentsCollection.register(UINib(nibName: "PreviewTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PreviewTypeCVC")
        segmentsCollection.delegate = self
        segmentsCollection.dataSource = self
        segmentsCollection.reloadData()
    }
    
    @IBOutlet weak var viewSegmentControl: UIView!
    
    @IBOutlet var segmentsCollection: UICollectionView!
    var segmentType: [SegmentType] = []
    private var segmentControl : UISegmentedControl!
    var selectedSegmentsIndex: Int = 0
    var dcrCall : CallViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //updateSegment()
        toLoadSegments()
    }
    
    deinit {
        print("ok bye")
    }

    @IBAction func startDetailingAction(_ sender: UIButton) {
        
        
        let productVC = UIStoryboard.productVC
        productVC.dcrCall = self.dcrCall
        self.navigationController?.pushViewController(productVC, animated: true)
        
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


