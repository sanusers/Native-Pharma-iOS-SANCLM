//
//  NearMeVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 26/08/23.
//

import Foundation
import UIKit
import GoogleMaps


enum TaggingType : String {
    case doctor = "D"
    case chemist = "C"
    case stockist = "S"
    case unlistedDoctor = "U"
    
    
    var name : String {
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        
        switch self {
            
        case .doctor:
            return appsetup.docCap ?? ""
        case .chemist:
            return appsetup.chmCap ?? ""
        case .stockist:
            return appsetup.stkCap ?? ""
        case .unlistedDoctor:
            return appsetup.nlCap ?? ""
        }
    }
    
}

class NearMeVC : UIViewController {
    
    
    
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet weak var viewMapView: GMSMapView!
    
    @IBOutlet weak var viewTaggedList: UIView!
    @IBOutlet weak var viewSegmentControl: UIView!
    @IBOutlet weak var viewVisitDetails: UIView!
    @IBOutlet weak var viewTableView: UIView!
    
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    
    @IBOutlet weak var visitTableView: UITableView!
    
    @IBOutlet weak var widthTableView: NSLayoutConstraint!
    
    
    private var visitListViewModel = VisitListViewModel()
    
    var currentLocation: CLLocationCoordinate2D?
    
    var tagType : TaggingType = .doctor {
        didSet {
            
            LocationManager.shared.getCurrentLocation{ (coordinate) in
                print("location == \(coordinate)")
                let camera : GMSCameraPosition = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 16)
                self.viewMapView.camera =  camera
                self.currentLocation = coordinate
                self.drawCircle()
                self.showAllTaggedList()
            }
            // self.showAllTaggedList()
        }
    }
    
    private var dcrSegmentControl : UISegmentedControl!
    
    // var taggingArray = ["Doctor" , "Chemist" , "Stockist" , "Unlisted Doctor" , "Cip" , "Hospital"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTitle()
        self.tagType = .doctor
        
        
        self.viewTableView.isHidden = true
        self.widthTableView.constant = 0
        //viewTableView.setSpecificCornersForTop(cornerRadius: 15)
        //viewTableView.setSpecificCornersForLeftCorners(cornerRadius: 15)
        //visitTableView.setSpecificCornersForLeftCorners(cornerRadius: 15)
        self.viewMapView.isMyLocationEnabled = true
       // self.viewMapView.settings.myLocationButton = true
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.headerCollectionView.collectionViewLayout = layout
        
        let location = LocationManager.shared.currentLocation
        print(location as Any)
        
         
        self.visitTableView.register(UINib(nibName: "TagViewCell", bundle: nil), forCellReuseIdentifier: "TagViewCell")
        
        
        [btnLeft,btnRight].forEach { button in
            button.layer.borderColor = AppColors.primaryColorWith_65per_alpha.cgColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 10
        }
        titleLbl.setFont(font: .bold(size: .SUBHEADER))
        btnLeft.isHidden = true
         
//        LocationManager.shared.getCurrentLocation{ (coordinate) in
//            print("location == \(coordinate)")
//            let camera : GMSCameraPosition = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 16)
//            self.viewMapView.camera =  camera
//            self.currentLocation = coordinate
//            self.drawCircle()
//            self.showAllTaggedList()
//        }
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tagView(_:)))
        viewMapView.addGestureRecognizer(tap)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LocationManager.shared.getCurrentLocation{ (coordinate) in
            print("location == \(coordinate)")
            let camera : GMSCameraPosition = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 16)
            self.viewMapView.camera =  camera
            self.currentLocation = coordinate
            self.drawCircle()
            self.showAllTaggedList()
        }
        
    }
    
    
    deinit {
        print("NearMeVC deallocated")
    }
    
    @objc func tagView (_ sender : UITapGestureRecognizer) {
        
        print("Taggggg")
        print(viewMapView.selectedMarker?.title ?? "Good")
    }
    
    
    func updateTitle() {
        let appsetUp = AppDefaults.shared.getAppSetUp()
        
        self.visitListViewModel.addTitleViewModel(TagTitleViewModel(tagTitle: tagTitle(name: appsetUp.docCap ?? "", type: .doctor)))
        
        if appsetUp.docNeed == 0 {
           // self.visitListViewModel.addTitleViewModel(TagTitleViewModel(tagTitle: tagTitle(name: appsetUp.docCap ?? "", type: .doctor)))
        }
        
        if appsetUp.chmNeed == 0 {
            self.visitListViewModel.addTitleViewModel(TagTitleViewModel(tagTitle: tagTitle(name: appsetUp.chmCap ?? "", type: .chemist)))
        }
        if appsetUp.stkNeed == 0 {
            self.visitListViewModel.addTitleViewModel(TagTitleViewModel(tagTitle: tagTitle(name: appsetUp.stkCap ?? "", type: .stockist)))
        }
        if appsetUp.unlNeed == 0 {
            self.visitListViewModel.addTitleViewModel(TagTitleViewModel(tagTitle: tagTitle(name: appsetUp.nlCap ?? "", type: .unlistedDoctor)))
        }
        
        self.headerCollectionView.reloadData()
    }
    
    
    func drawCircle(){
        let appsetup = AppDefaults.shared.getAppSetUp()
        var radiusL = CLLocationDistance()
        if let radius = appsetup.disRad{
            if let radiusFloat = Float(radius){
                let radiusmeter = radiusFloat * 1000
                radiusL = CLLocationDistance(radiusmeter)
            }
        }
        
        print(appsetup.disRad ?? "nothing")
        
        if let currentLocation = self.currentLocation{
            let geoFenceCircle = GMSCircle()
            geoFenceCircle.radius = radiusL
            geoFenceCircle.position = currentLocation
            geoFenceCircle.fillColor = UIColor.systemPink.withAlphaComponent(0.05)
            geoFenceCircle.strokeWidth = 3
            geoFenceCircle.strokeColor = UIColor.systemPink.withAlphaComponent(0.7)
            geoFenceCircle.map = viewMapView
        }
    }
    
    func handleMarkerCreation(type: TaggingType, custCode: String,  location: CLLocationCoordinate2D) {
        let appsetup = AppDefaults.shared.getAppSetUp()
        var radiusL = CLLocationDistance()
        if let radius = appsetup.disRad{
            if let radiusFloat = Float(radius){
                let radiusmeter = radiusFloat * 10000
                radiusL = CLLocationDistance(radiusmeter)
            }
        }
        
        switch type  {
        case .doctor:
            let doctors = DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            let doctor = doctors.filter { $0.code == custCode}.first
            guard let doctor = doctor else {return}
                if let latitude = doctor.lat,let longitude = doctor.long,let doubleLat = Double(latitude),let doubleLongitude = Double(longitude) {
                    let location = CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLongitude)
                    
                   
                        let current = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        print("distance : \(distance)")
                    
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.iconView?.frame.size = CGSize(width: 35, height: 50)
                            marker.title = doctor.name ?? ""
                            marker.snippet = doctor.addrs ?? ""
                            marker.addObserver(self, forKeyPath: "\(doctor.code ?? "")", context: nil)
                            
                            marker.map = viewMapView
                            marker.appearAnimation = .pop
                           
                            _ = mapView(viewMapView, didTap: marker)
                        }
                    
                }
            
            
        case .chemist:
            let chemists = DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            let chemist = chemists.filter { $0.code == custCode}.first
            guard let chemist = chemist else {return}
                if let latitude = chemist.lat , let longitude = chemist.long, let douableLat = Double(latitude), let doubleLong = Double(longitude) {
                    
                    let location = CLLocationCoordinate2D(latitude: douableLat, longitude: doubleLong)
                    
                    if let currentLocation = self.currentLocation{
                        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        print("distance : \(distance)")
                        
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.title = chemist.name ?? ""
                            marker.snippet = chemist.addr ?? ""
                            marker.appearAnimation = .pop
                            marker.map = viewMapView
                          
                           
                        }
                    }
                }
            
            
        case .stockist:
            let stockists = DBManager.shared.getStockist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            let stockist = stockists.filter { $0.code == custCode}.first
            guard let stockist = stockist else {return}
                if let latitude = stockist.lat , let longitude = stockist.long, let douableLat = Double(latitude), let doubleLong = Double(longitude) {
                    
                    let location = CLLocationCoordinate2D(latitude: douableLat, longitude: doubleLong)
                    
                    if let currentLocation = self.currentLocation{
                        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        print("distance : \(distance)")
                        
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.title = stockist.name ?? ""
                            marker.snippet = stockist.addr ?? ""
                            marker.appearAnimation = .pop
                            marker.map = viewMapView
                          
                           
                        }
                    }
                }
            
            
        case .unlistedDoctor:
            let unlistedDoctors = DBManager.shared.getUnListedDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            let unlistedDoctor = unlistedDoctors.filter { $0.code == custCode}.first
            guard let unlistedDoctor = unlistedDoctor else {return}
            
     
                if let latitude = unlistedDoctor.lat , let longitude = unlistedDoctor.long, let douableLat = Double(latitude), let doubleLong = Double(longitude) {
                    
                    let location = CLLocationCoordinate2D(latitude: douableLat, longitude: doubleLong)
                    
                    if let currentLocation = self.currentLocation{
                        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        
                        print("distance : \(distance)")
                        
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.title = unlistedDoctor.name ?? ""
                            marker.snippet = unlistedDoctor.addrs ?? ""
                            marker.appearAnimation = .pop
                            marker.map = viewMapView
                          
                            
                            
                        }
                    }
                }
            
        }
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
      if let title = marker.title {
        if let snippet = marker.snippet {
          print("marker title: \(title): snippet: \(snippet)")
        }
      }
      return true
    }

    
    private func showAllTaggedList() {
       self.viewMapView.clear()
        self.drawCircle()
        
        self.visitListViewModel.removeAll()
        
        let appsetup = AppDefaults.shared.getAppSetUp()
        var radiusL = CLLocationDistance()
        if let radius = appsetup.disRad{
            if let radiusFloat = Float(radius){
                let radiusmeter = radiusFloat * 10000
                radiusL = CLLocationDistance(radiusmeter)
            }
        }
        
        
        switch self.tagType {
        case .doctor:
            let doctors = DBManager.shared.getDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            for doctor in doctors {
                if let latitude = doctor.lat,let longitude = doctor.long,let doubleLat = Double(latitude),let doubleLongitude = Double(longitude) {
                    let location = CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLongitude)
                    
                    if let currentLocation = self.currentLocation{
                        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        print("distance : \(distance)")
                    
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.iconView?.frame.size = CGSize(width: 35, height: 50)
                            marker.title = doctor.name ?? ""
                            marker.snippet = doctor.addrs ?? ""
                            marker.addObserver(self, forKeyPath: "\(doctor.code ?? "")", context: nil)
                            
                            marker.map = viewMapView
                            
                            
                            let distanceRound = Double(round(1000 * distance) / 1000)
                            
                            self.visitListViewModel.addVisitViewModel(VisitViewModel(taggedDetail: TaggedDetails(name: doctor.name ?? "", address: doctor.addrs ?? "", meter: "\(distanceRound)", coordinates: location, custCode: doctor.code ?? "", tagType: self.tagType)))
                        }
                    }
                }
            }
            
        case .chemist:
            let chemists = DBManager.shared.getChemist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            for chemist in chemists {
                if let latitude = chemist.lat , let longitude = chemist.long, let douableLat = Double(latitude), let doubleLong = Double(longitude) {
                    
                    let location = CLLocationCoordinate2D(latitude: douableLat, longitude: doubleLong)
                    
                    if let currentLocation = self.currentLocation{
                        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        print("distance : \(distance)")
                        
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.title = chemist.name ?? ""
                            marker.snippet = chemist.addr ?? ""
                            marker.map = viewMapView
                            
                            let distanceRound = Double(round(1000 * distance) / 1000)
                            
                            self.visitListViewModel.addVisitViewModel(VisitViewModel(taggedDetail: TaggedDetails(name:  chemist.name ?? "", address: chemist.addr ?? "", meter: "\(distanceRound)", coordinates: location, custCode: chemist.code ?? "", tagType: self.tagType)))
                        }
                    }
                }
            }
            
        case .stockist:
            let stockists = DBManager.shared.getStockist(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            for stockist in stockists {
                if let latitude = stockist.lat , let longitude = stockist.long, let douableLat = Double(latitude), let doubleLong = Double(longitude) {
                    
                    let location = CLLocationCoordinate2D(latitude: douableLat, longitude: doubleLong)
                    
                    if let currentLocation = self.currentLocation{
                        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        print("distance : \(distance)")
                        
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.title = stockist.name ?? ""
                            marker.snippet = stockist.addr ?? ""
                            marker.map = viewMapView
                            
                            let distanceRound = Double(round(1000 * distance) / 1000)
                            
                            self.visitListViewModel.addVisitViewModel(VisitViewModel(taggedDetail: TaggedDetails(name: stockist.name ?? "", address: stockist.addr ?? "", meter: "\(distanceRound)", coordinates: location, custCode: stockist.code ?? "", tagType: self.tagType)))
                        }
                    }
                }
            }
            
        case .unlistedDoctor:
            let unlistedDoctors = DBManager.shared.getUnListedDoctor(mapID: LocalStorage.shared.getString(key: LocalStorage.LocalValue.selectedRSFID))
            
            for unlistedDoctor in unlistedDoctors {
                if let latitude = unlistedDoctor.lat , let longitude = unlistedDoctor.long, let douableLat = Double(latitude), let doubleLong = Double(longitude) {
                    
                    let location = CLLocationCoordinate2D(latitude: douableLat, longitude: doubleLong)
                    
                    if let currentLocation = self.currentLocation{
                        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let place = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let distance = current.distance(from: place)
                        
                        
                        print("distance : \(distance)")
                        
                        if distance <= radiusL {
                            let marker = GMSMarker()
                            marker.position = location
                            marker.icon = UIImage(named: "locationRed")
                            marker.title = unlistedDoctor.name ?? ""
                            marker.snippet = unlistedDoctor.addrs ?? ""
                            marker.map = viewMapView
                            
                            let distanceRound = Double(round(1000 * distance) / 1000)
                            
                            self.visitListViewModel.addVisitViewModel(VisitViewModel( taggedDetail: TaggedDetails(name: unlistedDoctor.name ?? "", address: unlistedDoctor.addrs ?? "", meter: "\(distanceRound)", coordinates: location, custCode: unlistedDoctor.code ?? "", tagType: self.tagType)))
                        }
                    }
                }
            }
        }
        self.visitTableView.reloadData()
    }
    
    
    private func att() {
        print("value")
    }
    
    
    @IBAction func addTagAction(_ sender: UIButton) {
        
        let taggingListVC = UIStoryboard.taggingListVC
        taggingListVC.type = self.tagType

        self.navigationController?.pushViewController(taggingListVC, animated: true)
        
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func leftViewAction(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 1.5) {
            self.viewTableView.isHidden = false
            self.widthTableView.constant = 300
            
            self.btnRight.isHidden = true
            self.btnLeft.isHidden = false
        }
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        
        LocationManager.shared.getCurrentLocation{ (coordinate) in
            print("location == \(coordinate)")
            let camera : GMSCameraPosition = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 16)
            self.viewMapView.camera =  camera
            self.currentLocation = coordinate
            self.drawCircle()
            self.showAllTaggedList()
        }
    }
    
    
    
    @IBAction func locationSettingAction(_ sender: UIButton) {
        
        LocationManager.shared.getCurrentLocation{ (coordinate) in
            print("location == \(coordinate)")
            let camera : GMSCameraPosition = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 16)
            self.viewMapView.camera =  camera
            self.currentLocation = coordinate
            self.drawCircle()
            self.showAllTaggedList()
        }
    }
    
    
    
    @IBAction func hideTableViewAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.5) {
            self.viewTableView.isHidden = true
            self.widthTableView.constant = 0
            
            self.btnLeft.isHidden = true
            self.btnRight.isHidden = false
        }
    }
    
    
}

extension NearMeVC : tableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visitListViewModel.numbersOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagViewCell", for: indexPath) as! TagViewCell
        let model = self.visitListViewModel.fetchDataAtIndex(indexPath.row)
        cell.visitDetail = model
        
        
        cell.addTap {
            self.handleMarkerCreation(type: self.tagType, custCode: model.custCode, location: model.coordinates)
        }
        
        return cell
    }
    
    
}


extension NearMeVC : collectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.visitListViewModel.numberofTitles()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DcrTagTitleCell", for: indexPath) as! DcrTagTitleCell
        cell.title = self.visitListViewModel.fetchTitleAtIndex(indexPath.row)
        
        if self.tagType.name == self.visitListViewModel.fetchTitleAtIndex(indexPath.row).name {
            cell.viewTitle.backgroundColor = UIColor.label.withAlphaComponent(0.5) //UIColor.lightGray
        }else {
            cell.viewTitle.backgroundColor = UIColor.clear
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? DcrTagTitleCell {
            cell.viewTitle.backgroundColor =  UIColor.label.withAlphaComponent(0.5)
            //UIColor.lightGray
        }
        
        self.tagType = self.visitListViewModel.fetchTitleAtIndex(indexPath.row).type
        
        self.headerCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DcrTagTitleCell {
            cell.viewTitle.backgroundColor = UIColor.clear
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  let label = UILabel()
      //  label.font = UIFont(name: "Satoshi-Bold", size: 20)!
       // label.text = self.visitListViewModel.fetchTitleAtIndex(indexPath.row).name
       // let sizeLabelFit = label.sizeThatFits(CGSize(width: self.headerCollectionView.frame.width-30, height: 50))

       // let size = CGSize(width: sizeLabelFit.width + 40, height: 50)
        
        return CGSize(width:self.visitListViewModel.fetchTitleAtIndex(indexPath.row).name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: collectionView.height)
        
        
       // return size
    }
}


private enum Constants {
    static let spacing: CGFloat = 1
}

