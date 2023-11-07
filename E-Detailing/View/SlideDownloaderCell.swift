//
//  SlideDownloaderCell.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 21/06/23.
//

import UIKit



class SlideDownloaderCell : UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDataBytes: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var btnPause: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}


class listView : UIView {
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
