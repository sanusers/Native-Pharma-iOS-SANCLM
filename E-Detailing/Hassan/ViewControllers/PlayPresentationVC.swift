//
//  PlayPresentationVC.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import UIKit
class PlayPresentationVC: BaseViewController {
 
    var selectedSlideModel: [SlidesModel]?
    @IBOutlet var playPresentationView: PlayPresentationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    class func initWithStory(model: [SlidesModel]) -> PlayPresentationVC {
        let reportsVC : PlayPresentationVC = UIStoryboard.Hassan.instantiateViewController()
        reportsVC.selectedSlideModel = model
        return reportsVC
    }
}
