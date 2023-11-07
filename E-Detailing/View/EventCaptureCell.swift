//
//  EventCaptureCell.swift
//  E-Detailing
//
//  Created by SANEFORCE on 26/09/23.
//

import Foundation
import UIKit


class EventCaptureCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    
    @IBOutlet weak var btnDelete: UIButton!
    
    
    var eventCapture : EventCaptureViewModel! {
        didSet {
            self.imgView.image = eventCapture.image
            self.txtName.text = eventCapture.title
            self.txtDescription.text = eventCapture.description
            
            if eventCapture.description == "" {
                self.txtDescription.text = "Description"
                self.txtDescription.textColor = .lightGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
