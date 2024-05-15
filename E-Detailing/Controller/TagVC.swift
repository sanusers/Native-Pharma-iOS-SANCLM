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

protocol TagVCDelegate: AnyObject {
    
    func didUsertagged()
    
}

class TagVC : UIViewController {
    
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet var custName: UILabel!
    
    @IBOutlet var btnTag: ShadowButton!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var backGroundVXview: UIVisualEffectView!
    
    
    @IBOutlet weak var viewMapView: GMSMapView!
    var viewTagStatus: AddNewTagInfoVIew?
    var checkinVIew: CustomerCheckinView?
    var userStatisticsVM = UserStatisticsVM()
    var delegate : TagVCDelegate?
    var customer : CustomerViewModel!
    var pickedImage: UIImage?
    var pickedImageName : String?
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
        custName.setFont(font: .bold(size: .SUBHEADER))
        custName.textColor = .appLightPink
        custName.text = customer.name
        btnTag.addTarget(self, action: #selector(checkCameraAuthorization), for: .touchUpInside)
        btnTag.backgroundColor = .appLightPink
        
        
//        Pipelines.shared.requestAuth { (coordinate) in
//            guard let coordinate = coordinate, let latitude = coordinate.latitude, let longitude =  coordinate.longitude else {return}
//            
//            let camera  = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 17)
//            
//            self.viewMapView.camera = camera
//            self.selectedCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            marker.iconView = UIImageView(image: UIImage(named: "locationRedIcon"))
//            marker.iconView?.tintColor = .appLightPink
//            marker.iconView?.frame.size = CGSize(width: 35, height: 45)
//            marker.title = self.customer.name
//            marker.map = self.viewMapView
//
//            Pipelines.shared.getAddressString(latitude: coordinate.latitude ?? Double(), longitude: coordinate.longitude ?? Double()) { address in
//                guard let address = address else {
//                    self.lblAddress.text = "No address found"
//                    return}
//                self.lblAddress.text = address
//            }
//            
//        }
        
        LocationManager.shared.getCurrentLocation { (coordinate) in
            
            let camera  = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 17)
            
            self.viewMapView.camera = camera
            self.selectedCoordinate = coordinate
            
            
            let marker = GMSMarker()
            marker.position = coordinate
            marker.iconView = UIImageView(image: UIImage(named: "locationRedIcon"))
            marker.iconView?.tintColor = .appLightPink
            marker.iconView?.frame.size = CGSize(width: 35, height: 45)
            marker.title = self.customer.name
            marker.map = self.viewMapView
        }
        
        backgroundView.addTap {
            self.didClose()
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

        toSetupAlert(desc: "Camera Permission Required", istoToreTry: false)
     }
    
    
    func toSetupAlert(desc: String, istoToreTry: Bool) {
        let commonAlert = CommonAlert()
        commonAlert.setupAlert(alert: "E - Detailing", alertDescription: desc, okAction: "cancel", cancelAction: "Ok")
        commonAlert.addAdditionalOkAction(isForSingleOption: false) {
            print("yes action")
         

        }
        
        commonAlert.addAdditionalCancelAction {
            print("no action")
          if  istoToreTry {
              guard let pickedImage =  self.pickedImage else {return}
              self.uploadImagess(image: pickedImage) { isCompleted in
                  
                  if isCompleted {
                      
                  } else {
                      
                      self.toSetupAlert(desc: "Image upload Failed Try again", istoToreTry: true)
                      
                  }
              }
            } else {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
         
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
        
        
        checkinVIew?.frame = CGRect(x: checkinVIewcenterX, y: checkinVIewcenterY, width: checkinVIewwidth, height: checkinVIewheight)
        
    }
    
    func checkinDetailsAction(dcrCall : CallViewModel) {
        
        self.selectedDCRcall = dcrCall
        backgroundView.isHidden = false
        //  backgroundView.toAddBlurtoVIew()
        self.view.subviews.forEach { aAddedView in
            switch aAddedView {
            case checkinVIew:
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
        
        checkinVIew = self.loadCustomView(nibname: XIBs.customerCheckinVIew) as? CustomerCheckinView
        checkinVIew?.delegate = self
       // checkinVIew?.dcrCall = dcrCall
        checkinVIew?.setupUItoAddTag(vm: dcrCall)
        //checkinVIew?.userstrtisticsVM = self.userststisticsVM
        //checkinVIew?.appsetup = self.appSetups

        
        
        self.view.addSubview(checkinVIew ?? CustomerCheckinView())
        
    }
    
    func fetchLatLongAndAddress(dcrCall : CallViewModel) {
     
     
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        let datestr = dateString
   
        dcrCall.checkinlatitude = self.selectedCoordinate.latitude
        dcrCall.checkinlongitude = self.selectedCoordinate.longitude
        dcrCall.dcrCheckinTime = datestr
        
        
        if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
            Shared.instance.showLoaderInWindow()
            let geocoder = GMSGeocoder()
            self.selectedCoordinate = viewMapView.camera.target
            let latitute = viewMapView.camera.target.latitude
            let longitude = viewMapView.camera.target.longitude
            let position = CLLocationCoordinate2DMake(latitute, longitude)
            geocoder.reverseGeocodeCoordinate(position) { response , error in
                Shared.instance.removeLoaderInWindow()
                if error != nil {
                    print("GMSReverseGeocode Error: \(String(describing: error?.localizedDescription))")
                 
                }else {
                    let result = response?.results()?.first
                    let address = result?.lines?.reduce("") { $0 == "" ? $1 : $0 + ", " + $1 }
                    print(address ?? "")
                    
 
                    self.lblAddress.text = address ?? "No address found."
                    dcrCall.customerCheckinAddress = address ?? "No address found."
                    self.checkinDetailsAction(dcrCall : dcrCall)
                }
            }
        } else {
            self.lblAddress.text = "No address found."
            dcrCall.customerCheckinAddress =  "No address found."
            self.checkinDetailsAction(dcrCall : dcrCall)
            
            
        }

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
    
    func toTaginfo(){
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
     //   let urlStr = APIUrl + "geodetails"
        
 //   http://crm.saneforce.in/iOSServer/db_module.php?axn=get/geodetails
        
        let divisionCode = (appsetup.divisionCode ?? "").replacingOccurrences(of: ",", with: "")
        
        let date = Date().toString(format: "yyyy-MM-dd")
        //{"tableName":"save_geo","lat":"13.02998466","long":"80.24142807","cuscode":"1679524","divcode":"63","cust":"D","tagged_time":"2024-05-15 17:07:20","image_name":"MGR0941_1679524_15052024170711.jpeg","sfname":"Sundara Kumar","sfcode":"MGR0941","addr":"No 4, Pasumpon Muthuramalinga Thevar Rd, Nandanam Extension, Nandanam, Chennai, Tamil Nadu 600035, India","tagged_cust_HQ":"MR5990","cust_name":"ASHISH.S.PURANDARE","mode":"Android-Edet","version":"Test.H.2","towncode":"104189","townname":"Nerangala","status":"1"}
        var params =  [String: Any]()
        params["tableName"] = "save_geo"
        params["lat"] = self.selectedCoordinate.latitude
        params["long"] = self.selectedCoordinate.longitude
        params["cuscode"] =  self.customer.code
        params["divcode"] =  divisionCode
        params["cust"] = self.customer.tagType
        params["tagged_time"] = date
        params["image_name"] = pickedImageName ?? ""
        params["sfname"] = appsetup.sfName ?? ""
        params["sfcode"] = appsetup.sfCode ?? ""
        params["addr"] = self.lblAddress.text ?? ""
        params["status"] = "1"
        params["tagged_cust_HQ"] = LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID)
        params["cust_name"] = self.customer.name
        params["mode"] = "iOS-Edet"
        params["version"] = "iEdet.1.1"
        
        
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: params)
        var toSendParam = [String: Any]()
        
        toSendParam["data"] = jsonDatum
        Shared.instance.showLoaderInWindow()
        userStatisticsVM.toUploadTaggedInfo(params: toSendParam, api: .saveTag, paramData: toSendParam) { result in
            Shared.instance.removeLoaderInWindow()
            switch result {
                
            case .success(let model):
                if model.isSuccess ?? false {
                    guard let pickedImage = self.pickedImage else {return}
                    self.uploadImagess(image: pickedImage) { isSuccess in
                        if isSuccess {
                            
                            self.delegate?.didUsertagged()
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            self.toSetupAlert(desc: "Image upload Failed Try again", istoToreTry: true)
                        }
                    }
                } else {
                    self.toCreateToast(model.msg ?? "Couldn't tag info for now try again later.")
                }
    
            case .failure(_):
                self.toCreateToast("Couldn't tag info for now try again later.")
                
            }
            
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
        self.pickedImage = image
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        let code = appsetup.sfCode ?? ""
        let uuid = "\(UUID())"
        let uuidStr = uuid.replacingOccurrences(of: "-", with: "")
        let custCode = customer.code
        let taggedImageName = code + "_" + custCode + uuidStr + ".jpeg"
        self.pickedImageName = taggedImageName
        
        switch customer.type {
            
        case .doctor:
            self.selectedDCRcall = CallViewModel(call: customer.tag, type: .doctor)
        case .chemist:
            self.selectedDCRcall = CallViewModel(call: customer.tag, type: .chemist)
        case .stockist:
            self.selectedDCRcall = CallViewModel(call: customer.tag, type: .stockist)
        case .unlistedDoctor:
            self.selectedDCRcall = CallViewModel(call: customer.tag, type: .unlistedDoctor)
        }
        guard let aCallVM =  self.selectedDCRcall else {return}
        self.selectedDCRcall =    aCallVM.toRetriveDCRdata(dcrcall: aCallVM.call)
      
       
        self.fetchLatLongAndAddress(dcrCall:  self.selectedDCRcall!)
        
      
    }
    
    func uploadImagess(image: UIImage, completion: @escaping (Bool) -> ()) {
        let appsetup = AppDefaults.shared.getAppSetUp()

        
        let params = ["tableName" : "imgupload",
                      "sfcode" : appsetup.sfCode ?? "",
                      "division_code" : (appsetup.divisionCode ?? "").replacingOccurrences(of: ",", with: ""),
                      "Rsf" : appsetup.sfCode ?? "",
                      "sf_type" : appsetup.sfType ?? "",
                      "Designation" : appsetup.dsName ?? "",
                      "state_code" : appsetup.stateCode ?? "",
                      "subdivision_code" : appsetup.subDivisionCode ?? "",
        ] as [String : Any]
        let jsonDatum = ObjectFormatter.shared.convertJson2Data(json: params)
        var toSendParam = [String: Any]()
        toSendParam["data"]  = jsonDatum
  //  http://crm.saneforce.in/iOSServer/db_api.php/?axn=save/image


        let custCode = customer.code
 
        Shared.instance.showLoaderInWindow()
     
        userStatisticsVM.toUploadCapturedImage(params: params, uploadType: .tagging, api: .imageUpload, image: [image], imageName: [pickedImageName ?? ""], paramData: jsonDatum, custCode: custCode) { result in
            Shared.instance.removeLoaderInWindow()
            switch result {
            case .success(let response):
                dump(response)
           
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: [])
           
                  let generalResponse = try JSONDecoder().decode(GeneralResponseModal.self, from: jsonData)
                 print(generalResponse)
                    if generalResponse.isSuccess ?? false {
                        self.toCreateToast("Image upload completed")
                        completion(true)
                    } else {
                       
                        completion(false)
                    }
                 
                } catch {
                    print("Error converting parameter to JSON: \(error)")
                    completion(false)
                }

                
            case .failure(let error):
                dump(error.localizedDescription)
                completion(false)
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
        if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isConnectedToNetwork) {
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
        } else {
            self.lblAddress.text = "No address found"
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

            case checkinVIew:
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

            case checkinVIew:
                aAddedView.removeFromSuperview()
                aAddedView.alpha = 0
                
            
               // self.navigateToPrecallVC(dcrCall: callViewModel, index: self.selectedDCRIndex ?? 0)
                
            default:
                aAddedView.isUserInteractionEnabled = true
                aAddedView.alpha = 1
                print("Yet to implement")
                
                // aAddedView.alpha = 1
                
            }
            
        }
        
    
        
        
        self.toTaginfo()
        
    }
    
    
}
