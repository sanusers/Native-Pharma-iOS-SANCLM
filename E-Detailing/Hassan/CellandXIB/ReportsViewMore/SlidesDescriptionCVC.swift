//
//  SlidesDescriptionCVC.swift
//  E-Detailing
//
//  Created by San eforce on 30/05/24.
//

import UIKit

class SlidesDescriptionCVC: UICollectionViewCell, RatingStarViewDelegate {
    func didRatingAdded(rating: Float) {
        print("Yet to")
    }
    
    
    @IBOutlet var brandNamelbl: UILabel!
    @IBOutlet var reviewView: UIView!
    @IBOutlet var feedbackLbl: UILabel!
    var selectedIndex: Int = 0
    @IBOutlet var timeline: UILabel!
    var addedreviewView: RatingStarView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func populateCell(model: SlideDetailsResponse) {
        brandNamelbl.text = model.productName
        feedbackLbl.text = model.feedback
        let endTime = model.endTime.toDate(format: "yyyy-MM-dd HH:mm:ss")
        let startTime = model.startTime.toDate(format: "yyyy-MM-dd HH:mm:ss")
        timeline.text = "\(endTime.toString()) - \(startTime.toString())"
       
    }
    
    override func layoutSubviews() {
        addedreviewView?.frame = reviewView.bounds
        reviewView.addSubview(addedreviewView ?? RatingStarView())
    }
    
    func setupUI(currentRating: Int, selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        addedreviewView = RatingStarView()
        addedreviewView?.currentRating = currentRating
        addedreviewView?.delegate = self
        addedreviewView?.prevValue(value: CGFloat(currentRating))
    }

}
