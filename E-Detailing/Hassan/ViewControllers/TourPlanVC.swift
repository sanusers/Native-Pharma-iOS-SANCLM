//
//  TourPlanVC.swift
//  E-Detailing
//
//  Created by San eforce on 09/11/23.
//

import Foundation
import UIKit
class TourPlanVC: BaseViewController {
    
    var homeVM: HomeViewModal?
   
    @IBOutlet var tourPlanView: TourPlanView!
    
    
    override func viewDidLoad() {
        
       
    }
    
    
    class func initWithStory() -> TourPlanVC {
        let tourPlanVC : TourPlanVC = UIStoryboard.Hassan.instantiateViewController()
        tourPlanVC.homeVM = HomeViewModal()
        return tourPlanVC
    }
    
    
    func getAllPlansData(_ param: [String: Any], paramData: Data, completion: @escaping (Result<SessionResponseModel,Error>) -> Void){
        let sessionResponseVM = SessionResponseVM()
        sessionResponseVM.getTourPlanData(params: param, api: .getAllPlansData, paramData: paramData) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
                dump(response)
                
            case .failure(let error):
                print(error.localizedDescription)
                
                completion(.failure(error))
            }
        }
    }
}
    



