//
//  SlideDownloadVC.swift
//  E-Detailing
//
//  Created by NAGAPRASATH on 21/06/23.
//

import UIKit
import Alamofire


typealias SlidesCallBack = (_ status: Bool) -> Void
 
class SlideDownloadVC : UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var slides = [ProductSlides]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "SlideDownloaderCell", bundle: nil), forCellReuseIdentifier: "SlideDownloaderCell")
        
        self.slides = DBManager.shared.getSlide()
        self.tableView.reloadData()
        
       // self.downloadSlideData()
    }
    
    
    @IBAction func CloseAction(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    
    func getFileValue(int: Int, data : [String : Any],callback : @escaping SlidesCallBack) {
        
        let url = URL(string: AppDefaults.shared.webUrl + AppDefaults.shared.slideUrl + "\(self.slides[int].filePath!.replacingOccurrences(of: " ", with: "%20"))")!
        
        
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request , completionHandler: { (data, response, error) in
            
            if error != nil {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 200 {
                    
                    DispatchQueue.main.async {
                        
                        // self.data = data
                    }
                }
                
                var slides = AppDefaults.shared.getSlides()
                if !slides.isEmpty {
                    slides.removeFirst()
                    AppDefaults.shared.save(key: .slide, value: slides)
                    callback(true)
                }
            }
        }).resume()
    }
    
    
    func downloadSlideData() {
        DispatchQueue.global(qos: .background).async {
            let slides = AppDefaults.shared.getSlides()
            
            guard let slide = slides.first else{
                return
            }
            self.getFileValue(int: 0, data: slide){ (_) in
                self.downloadSlideData()
            }
        } // 'TEST123VP','456'
        
//        for i in 0..<self.slides.count {
//
//            let url = AppDefaults.shared.webUrl + AppDefaults.shared.slideUrl + (self.slides[i].filePath ?? "")
//            print(url)
//
//            self.getFileValue(int: i)
//
//
////            AF.request(url,method: .get).responseData(){ (responseFeed) in
////
////                switch responseFeed.result {
////
////                    case .success(_):
////
////                    print(responseFeed.data!)
////                        do {
////                            let apiResponse = try JSONSerialization.jsonObject(with: responseFeed.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
////
////                            let date1 = Date()
////
////                            print(date1)
////
////                            print("ssususnbjbo")
////                            print(apiResponse)
////                            print("ssusus")
////
////
////
////                        }catch {
////                            print(error)
////                        }
////                    case .failure(let error):
////
//////                    DispatchQueue.main.async {
//////                        ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
//////                    }
////                        ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
////                        print(error)
////                        return
////                }
////            }
//
////            AF.request(url).response() { (responseFeed) in
////
////                print(responseFeed)
////
////                switch responseFeed.result {
////
////                    case .success(_):
////                        do {
////                            let apiResponse = try JSONSerialization.jsonObject(with: responseFeed.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
////
////                            let date1 = Date()
////
////                            print(date1)
////
////                            print("ssususnbjbo")
////                            print(apiResponse)
////                            print("ssusus")
////
////
////
////                        }catch {
////                            print(error)
////                        }
////                    case .failure(let error):
////
//////                    DispatchQueue.main.async {
//////                        ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
//////                    }
////                        ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
////                        print(error)
////                        return
////                }
////            }
//
//        }
        
    }
    
    
}


extension SlideDownloadVC : tableViewProtocols {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.slides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlideDownloaderCell", for: indexPath) as! SlideDownloaderCell
        cell.lblName.text = self.slides[indexPath.row].name
        cell.progressView.progress = 1.0
        return cell
    }
    
    
}
