//
//  TagVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 28/08/23.
//

import Foundation
import UIKit
import GoogleMaps
import Alamofire
import MobileCoreServices
import CoreData
import AVFoundation
class TagVC : UIViewController {
    
    
    @IBOutlet weak var lblAddress: UILabel!
    
    
    @IBOutlet var btnTag: ShadowButton!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backGroundVXview: UIVisualEffectView!
    @IBOutlet weak var viewMapView: GMSMapView!
    var viewTagStatus: AddNewTagInfoVIew?
    var userStatisticsVM : UserStatisticsVM?
    
    var customer : CustomerViewModel!
    
    //var doctor : DoctorFencing!
    
    var selectedCoordinate : CLLocationCoordinate2D!
    var selectedDCRcall: CallViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.isHidden = true
        self.backGroundVXview.isHidden = true
        self.viewMapView.isMyLocationEnabled = true
        self.viewMapView.settings.myLocationButton = true
        self.viewMapView.settings.scrollGestures = false
        self.viewMapView.delegate = self
      
        
        btnTag.addTarget(self, action: #selector(checkCameraAuthorization), for: .touchUpInside)
        
        LocationManager.shared.getCurrentLocation { (coordinate) in
            
            let camera  = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 17)
            
            self.viewMapView.camera = camera
            self.selectedCoordinate = coordinate
            
            
            let marker = GMSMarker()
            marker.position = coordinate
            marker.iconView = UIImageView(image: UIImage(named: "locationRedIcon"))
            marker.iconView?.tintColor = .appLightPink
            marker.iconView?.frame.size = CGSize(width: 35, height: 50)
            marker.title = self.customer.name
            marker.map = self.viewMapView
        }
    }
    
    deinit {
        print("TagVC deallocated")
    }
    func setupCamera() {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .camera
        pickerVC.delegate = self
        
        self.navigationController?.present(pickerVC, animated: true)
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            if granted {
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            }
        }
    }
    
    
    func promptToOpenSettings() {

        toSetupAlert(desc: "Camera Permission Required")
     }
    
    
    func toSetupAlert(desc: String) {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: desc, okAction: "cancel", cancelAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: false) {
            print("yes action")
         

        }
        
        commonAlert.addAdditionalCancelAction {
            print("no action")
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    }
    
    @objc func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
         case .authorized:
             setupCamera()
         case .notDetermined:
             requestCameraPermission()
         case .denied, .restricted:
             promptToOpenSettings()
         @unknown default:
             fatalError("Unknown case for camera authorization status.")
         }
     }
    
    @IBAction func didTapBackBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let checkinVIewwidth = view.bounds.width / 3
        let checkinVIewheight = view.bounds.height / 2
        
        let checkinVIewcenterX = view.bounds.midX - (checkinVIewwidth / 2)
        let checkinVIewcenterY = view.bounds.midY - (checkinVIewheight / 2)
        
        
        viewTagStatus?.frame = CGRect(x: checkinVIewcenterX, y: checkinVIewcenterY, width: checkinVIewwidth, height: checkinVIewheight)
        
    }
    
    func fetchLatLongAndAddress(dcrCall : CallViewModel) {
     
        
        Shared.instance.showLoaderInWindow()
   
            
        Pipelines.shared.getAddressString(latitude: selectedCoordinate.latitude, longitude:  selectedCoordinate.longitude) {  address in
                Shared.instance.removeLoaderInWindow()
             

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let currentDate = Date()
                let dateString = dateFormatter.string(from: currentDate)
                
                let datestr = dateString
                
                ///time
                dateFormatter.dateFormat = "HH:mm:ss"
                
                let timeString = dateFormatter.string(from: currentDate)
                
                _ = (timeString)
                dcrCall.customerCheckinAddress = address ?? ""
                dcrCall.checkinlatitude = self.selectedCoordinate.latitude
                dcrCall.checkinlongitude = self.selectedCoordinate.longitude
                dcrCall.dcrCheckinTime = datestr
                self.checkinDetailsAction(dcrCall : dcrCall)
            }

        
    }
    
    
    func checkinDetailsAction(dcrCall : CallViewModel) {
        self.selectedDCRcall = dcrCall
      
        backgroundView.isHidden = false
        backGroundVXview.alpha = 0.3
        
        self.view.subviews.forEach { aAddedView in
            switch aAddedView {
            case viewTagStatus:
                aAddedView.removeFromSuperview()
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
            case backgroundView:
        
                aAddedView.isUserInteractionEnabled = true
            default:
                
                print("Yet to implement")
                aAddedView.isUserInteractionEnabled = false
                
                
            }
            
        }
        
        viewTagStatus = self.loadCustomView(nibname: XIBs.addNewTagInfoVIew) as? AddNewTagInfoVIew
        guard let viewTagStatus = viewTagStatus else{
            
            print("unable to root view")
            
            return}
        
        viewTagStatus.delegate = self

        viewMapView.addSubview(viewTagStatus)

    }
    
    
    func showAlert() {
        print("Yet to implement")
        showAlertToEnableLocation()
    }
    
    func showAlertToEnableLocation() {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: "Please enable location services in Settings.", okAction: "Cancel",cancelAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: false) {
            print("no action")
            // self.toDeletePresentation()
            
        }
        commonAlert.addAdditionalCancelAction {
            print("yes action")
            self.redirectToSettings()
            
        }
    }
    
    func redirectToSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    func tagging() {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let urlStr = APIUrl + "geodetails"
        
 //   http://crm.saneforce.in/iOSServer/db_module.php?axn=get/geodetails
        
        _ = (appsetup.divisionCode ?? "").replacingOccurrences(of: ",", with: "")
        
        _ = Date().toString(format: "yyyy-MM-dd HH:mm:ss")
        let params =  [String: Any]()
//        ["tableName" : "save_geo",
//                      "lat" : self.selectedCoordinate != nil ? "\(self.selectedCoordinate.latitude)" : "0.0000",
//                      "long" : self.selectedCoordinate != nil ? "\(self.selectedCoordinate.longitude)" : "0.0000",
//                      "cuscode" : self.customer.code,
//                      "divcode" : divisionCode,
//                      "cust" : self.customer.tagType,
//                      "tagged_time" : date,
//                      "image_name" : "",
//                      "sfname" : appsetup.sfName ?? "",
//                      "sfcode" : appsetup.sfCode ?? "",
//                      "addr" : self.lblAddress.text ?? "",
//                      "tagged_cust_HQ" : appsetup.sfCode ?? "",
//                      "cust_name" : self.customer.name,
//                      "mode" : "iOS-Edet-New",
//                      "version" : "iEdet.1.1",
//        ]
        
        let param = ["data" : params.toString()]
        
        print(urlStr)
        print(param)
        
        AF.request(urlStr,method: .post,parameters: param).responseData(){ (response) in
            
            switch response.result {
                
                case .success(_):
                    do {
                        
                        print(response)
                        
                        let apiResponse = try? JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        let date1 = Date()
                        
                        print(date1)
        
                        print("ssususnbjbo")
                      //  print(apiResponse)
                        print("ssusus")
                        self.updateTagList()
                        self.popToBack(UIStoryboard.nearMeVC)
                        
                      //  self.navigationController?.popViewController(animated: true)
                        
                    }
                case .failure(let error):
                
                  //  ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
                    print(error)
                    return
            }
            
            print("2")
            print(response)
            print("2")
        }
    }
    
    private func popToBack<T>(_ VC : T) {
        let mainVC = navigationController?.viewControllers.first{$0 is T}
        
        if let vc = mainVC {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    
    func updateTagList()  {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        // http://crm.saneforce.in/iOSServer/db_api.php?axn=table/dcrmasterdata
        
        let url = APIUrl + "table/dcrmasterdata"
        
        var paramsDict = ""
        var params : [String : Any] = [:]

        switch self.customer.type {
        case .doctor:
            paramsDict = "{\"tableName\":\"getdoctors\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\",\"subdivision_code\":\"\(appsetup.subDivisionCode!)\"}"

            params  = ["data" : paramsDict]
            
        case .chemist:
            paramsDict = "{\"tableName\":\"getchemist\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\"}"
            
            params = ["data": paramsDict]
        
        case .stockist:
            paramsDict = "{\"tableName\":\"getstockist\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\"}"
            
            params = ["data": paramsDict]
            
        case .unlistedDoctor:
            paramsDict = "{\"tableName\":\"getunlisteddr\",\"sfcode\":\"\(appsetup.sfCode!)\",\"division_code\":\"\(appsetup.divisionCode!)\",\"Rsf\":\"\(appsetup.sfCode!)\",\"sf_type\":\"\(appsetup.sfType!)\",\"Designation\":\"\(appsetup.dsName!)\",\"state_code\":\"\(appsetup.stateCode!)\"}"
            
            params = ["data": paramsDict]
            
        }
        
        
        AF.request(url, method: .post ,parameters: params).responseData { responseFeed in
            
            switch responseFeed.result {
                
            case .success(_):
                do {
                    let apiResponse = try JSONSerialization.jsonObject(with: responseFeed.data!,options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    print(apiResponse)
                    
                    guard let responseArray = apiResponse as? [[String : Any]] else {
                        return
                    }
                    
                    
                    switch self.customer.type {
                        
                    case .doctor:
                        DBManager.shared.saveMasterData(type: .doctorFencing, Values: responseArray, id: appsetup.sfCode ?? "")
                    case .chemist:
                        DBManager.shared.saveMasterData(type: .chemists, Values: responseArray, id: appsetup.sfCode ?? "")
                    case .stockist:
                        DBManager.shared.saveMasterData(type: .stockists, Values: responseArray, id: appsetup.sfCode ?? "")
                    case .unlistedDoctor:
                        DBManager.shared.saveMasterData(type: .unlistedDoctors, Values: responseArray, id: appsetup.sfCode ?? "")
                    }
                    
                }catch {
                    print(error)
                }
            case .failure(let Error):
                print(Error)
            }
        }
    }
    

    
    @IBAction func cancelAction(_ sender: UIButton) {
        UIView.animate(withDuration: 1.5) {
            self.didClose()
        }
    }
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        self.tagging()
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension TagVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        var aCallVM: CallViewModel?
        
        switch customer.type {
            
        case .doctor:
             aCallVM = CallViewModel(call: customer.tag, type: .doctor)
        case .chemist:
             aCallVM = CallViewModel(call: customer.tag, type: .chemist)
        case .stockist:
             aCallVM = CallViewModel(call: customer.tag, type: .stockist)
        case .unlistedDoctor:
             aCallVM = CallViewModel(call: customer.tag, type: .unlistedDoctor)
        }
      
        guard let aCallVM = aCallVM else {return}
        self.selectedDCRcall = aCallVM
        self.fetchLatLongAndAddress(dcrCall: aCallVM)
        
      
    }
    
    func uploadImagess(image: UIImage) {
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        let webUrlString = AppDefaults.shared.webUrl
        
        let urlString = webUrlString.contains("http://") ? webUrlString : "http://" + webUrlString
        
        let surl = urlString  + "/" + AppDefaults.shared.iosUrl + "save/image"
        
        print(surl)
        
        let params = ["tableName" : "imgupload",
                      "sfcode" : appsetup.sfCode ?? "",
                      "division_code" : (appsetup.divisionCode ?? "").replacingOccurrences(of: ",", with: ""),
                      "Rsf" : appsetup.sfCode ?? "",
                      "sf_type" : appsetup.sfType ?? "",
                      "Designation" : appsetup.dsName ?? "",
                      "state_code" : appsetup.stateCode ?? "",
                      "subdivision_code" : appsetup.subDivisionCode ?? "",
        ] as [String : Any]
        
  //  http://crm.saneforce.in/iOSServer/db_api.php/?axn=save/image
        
        let url = URL(string: surl)!
        let code = appsetup.sfCode ?? ""
        let uuid = "\(UUID())"
        let uuidStr = uuid.replacingOccurrences(of: "-", with: "")
        let custCode = customer.code
        let taggedImageName = code + "_" + custCode + uuidStr + ".jpeg"
     
        userStatisticsVM?.toUploadCapturedImage(params: params, api: .imageUpload, image: [image], imageName: [taggedImageName], paramData: params, custCode: custCode) { result in
            switch result {
            case .success(let response):
                dump(response)
                
                
            case .failure(let error):
                dump(error.localizedDescription)
            }
            
            
        }
    }
    
    
    private func mimeType(for path: String) -> String {
        let pathExtension = URL(fileURLWithPath: path).pathExtension as NSString
        guard
            let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, nil)?.takeRetainedValue(),
            let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue()
        else {
            return "application/octet-stream"
        }

        return mimetype as String
    }
}




extension TagVC: GMSMapViewDelegate{
    /**
     * Called repeatedly during any animations or gestures on the map (or once, if the camera is
     * explicitly set). This may not be called for all intermediate camera positions. It is always
     * called for the final position of an animation or gesture.
     */
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        print("didchange")
        returnPostionOfMapView(mapView: mapView)
    }
    
    /**
     * Called when the map becomes idle, after any outstanding gestures or animations have completed (or
     * after the camera has been explicitly set).
     */
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("idleAt")
        
        //called when the map is idle
        returnPostionOfMapView(mapView: mapView)
        
    }
    
    //Convert the location position to address
    func returnPostionOfMapView(mapView:GMSMapView){
        let geocoder = GMSGeocoder()
        self.selectedCoordinate = mapView.camera.target
        let latitute = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        let position = CLLocationCoordinate2DMake(latitute, longitude)
        geocoder.reverseGeocodeCoordinate(position) { response , error in
            if error != nil {
                print("GMSReverseGeocode Error: \(String(describing: error?.localizedDescription))")
            }else {
                let result = response?.results()?.first
                let address = result?.lines?.reduce("") { $0 == "" ? $1 : $0 + ", " + $1 }
                print(address ?? "")
                self.lblAddress.text = address
            }
        }
    }
}


extension TagVC : addedSubViewsDelegate {
    func didUpdateCustomerCheckin(dcrCall: CallViewModel) {
        print("Yet to implement")
    }
    
    

    
    
    func didUpdateFilters(filteredObjects: [NSManagedObject]) {
        print("Yet to implement")
    }
    
   
    
    
    
    


    func didClose() {
       backgroundView.isHidden = true
        self.view.subviews.forEach { aAddedView in
            
            switch aAddedView {


                
            case viewTagStatus:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
                
                // aAddedView.alpha = 1
                
            }
            
        }
    }
    

    
    func didUpdate() {
        backgroundView.isHidden = true
        self.view.subviews.forEach { aAddedView in
            
            switch aAddedView {

            case viewTagStatus:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                
                guard let callViewModel = self.selectedDCRcall else {return}
                
               // self.navigateToPrecallVC(dcrCall: callViewModel, index: self.selectedDCRIndex ?? 0)
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
                
                // aAddedView.alpha = 1
                
            }
            
        }
    }
    
    
}
