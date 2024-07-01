//
//  MainVC+Checkins.swift
//  SAN ZEN
//
//  Created by San eforce on 29/06/24.
//

import Foundation
extension MainVC {
    
    func istoRedirecttoCheckin() -> Bool {
        

        var currentDate : Date?
        if !isSequentialDCRenabled {
            if self.selectedToday == nil {
                return false
            } else {
                guard let nonNillsessions = self.sessions   else {
                    currentDate = Shared.instance.selectedDate
                    return true
                }
                
                guard nonNillsessions[0].workType != nil else {
                    currentDate = Shared.instance.selectedDate
                    return true
                }
                
              return false
            }
        }
        guard let currentDate = currentDate else {return false}
        
        // Assuming you have a storedDateString retrieved from local storage
        let storedDateString = LocalStorage.shared.getString(key: LocalStorage.LocalValue.lastCheckedInDate)
        let storedDate =  storedDateString.toDate(format: "yyyy-MM-dd")
        //dateFormatter.date(from: storedDateString) ?? Date()
        if !Calendar.current.isDate(currentDate, inSameDayAs: storedDate) {
            // CoreDataManager.shared.removeAdayPlans(planDate: currentDate)
        }
        if isDayCheckinNeeded {
            
            if !Calendar.current.isDate(currentDate, inSameDayAs: storedDate) {
                LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserCheckedin, value: false)
                ///Dont change titile it may break underlying chekin details view actions
                self.btnFinalSubmit.setTitle("Check IN", for: .normal)
                
                
                return true
                
                
            }
            
            
            let lastcheckedinDate =  toReturnLastCheckinDate()?.toString(format: "yyyy-MM-dd") ?? ""
            //LocalStorage.shared.getString(key: LocalStorage.LocalValue.lastCheckedInDate) //"2024-02-28 14:19:54"
            
            
            let toDayDate = currentDate.toString(format: "yyyy-MM-dd")
            
            if toDayDate == lastcheckedinDate {
                
                if  LocalStorage.shared.getBool(key: LocalStorage.LocalValue.userCheckedOut) {
                    self.configureAddCall(false)
                    self.btnFinalSubmit.isUserInteractionEnabled = false
                    self.btnFinalSubmit.alpha = 0.5
                    
                }
                
            
                    self.btnFinalSubmit.setTitle(isDayCheckinNeeded ?  "Final submit / Check OUT" : "Final submit", for: .normal)
          
               
                return false
            } else {
                
                LocalStorage.shared.setBool(LocalStorage.LocalValue.userCheckedOut, value: false)
                
                self.configureAddCall(true)
                
                if LocalStorage.shared.getBool(key: LocalStorage.LocalValue.isUserCheckedin) {
                    self.btnFinalSubmit.setTitle(isDayCheckinNeeded ?  "Final submit / Check OUT" : "Final submit", for: .normal)
                    return false
                    
                } else {
                    self.btnFinalSubmit.setTitle("Check IN", for: .normal)
                    return true
                }
                
                
            }
            
            
            
        } else {
            self.btnFinalSubmit.setTitle(isDayCheckinNeeded ?  "Final submit / Check OUT" : "Final submit", for: .normal)
            self.configureAddCall(true)
            return false
        }
    }
    
    func checkoutAction() {
        Pipelines.shared.requestAuth() {[weak self] coordinates  in
            guard let welf = self else {return}
            
            if geoFencingEnabled {
                guard coordinates != nil else {
                    welf.showAlertToNetworks(desc: "Please enable location services in Settings.", isToclearacalls: false)
               
                    return
                }
            }
            
            Pipelines.shared.getAddressString(latitude: coordinates?.latitude ?? Double(), longitude:  coordinates?.longitude ?? Double()) { [weak self] address in
                guard let welf = self else {return}
  
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let currentDate = welf.toMergeDate(selectedDate: Shared.instance.selectedDate) ?? Date()
                let dateString = dateFormatter.string(from: currentDate)
                
                let datestr = dateString
                
                ///time
                dateFormatter.dateFormat = "HH:mm:ss"
                
                let timeString = dateFormatter.string(from: currentDate)
                
                let timestr = (timeString)
                
                
                let achckinInfo = CheckinInfo(address: address, checkinDateTime: "" , checkOutDateTime: welf.getCurrentFormattedDateString(selecdate: currentDate), latitude:  coordinates?.latitude ?? Double(), longitude:  coordinates?.latitude ?? Double(), dateStr: datestr, checkinTime: "", checkOutTime: timestr)
                
                 welf.fetchCheckins(checkin: achckinInfo) {[weak self] checkin in
                     guard let welf = self else {return}
                     CoreDataManager.shared.removeAllCheckins()
                     CoreDataManager.shared.saveCheckinsToCoreData(checkinInfo: checkin) { _ in
                         welf.checkinDetailsAction(checkin: checkin)
                     }
                }
                
                
            }
            
            
            
        }
    }
    func configurePastWindups() {
        if let notWindedups = toReturnNotWindedupDate() {
            if let notWindedupDate = notWindedups.statusDate {
                Shared.instance.selectedDate = notWindedupDate
                selectedDate = toTrimDate(date: notWindedupDate, isForMainLabel: false)
                selectedToday = notWindedupDate
                celenderToday = notWindedupDate
                todayCallsModel = nil
                callsCountLbl.text = "Call Count: \(0)"
                toConfigureMydayPlan(planDate: notWindedupDate)
                setDateLbl(date: notWindedupDate)
                setSegment(.workPlan)
                tourPlanCalander.reloadData()
            }
        }
        validateWindups()
    }
    
    func reserCallModule(lastCheckinDate: Date?) {
        if let lastCheckinDate = lastCheckinDate {
            let lastCheckinDate = lastCheckinDate.toString(format: "yyyy-MM-dd")
            LocalStorage.shared.setSting(LocalStorage.LocalValue.lastCheckedInDate, text: lastCheckinDate)
            LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserCheckedin, value: true)
        } else {
            LocalStorage.shared.setSting(LocalStorage.LocalValue.lastCheckedInDate, text: "")
            LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserCheckedin, value: false)
        }
        LocalStorage.shared.setBool(LocalStorage.LocalValue.userCheckedOut, value: false)
        LocalStorage.shared.setBool(LocalStorage.LocalValue.didUserWindUP, value: false)
        isDayPlanRemarksadded = false
        configureFinalsubmit(true)
        configureAddCall(true)
        if isDayCheckinNeeded {
            if istoRedirecttoCheckin() {
                checkinAction()
            }
        }

    }
    
    func validateWindups() {
        var isDateWindup: Bool = false
        let selectedDateStr = Shared.instance.selectedDate.toString(format: "yyyy-MM-dd")
        var lastCheckinDate : Date?
        if let windedUps = toReturnWindedupDates() {
            for windedUp in windedUps {
                if let windedUpDate = windedUp.statusDate {
                    let windedUpDateStr = windedUpDate.toString(format: "yyyy-MM-dd")
                    lastCheckinDate = windedUpDate
                    isToRegretCheckin = true
                    if windedUpDateStr == selectedDateStr && windedUp.didUserWindup {
                        isDateWindup = true
                        break
                    }
                }
            }
        }
        
        if isDateWindup {
            LocalStorage.shared.setSting(LocalStorage.LocalValue.lastCheckedInDate, text: selectedDateStr)
            LocalStorage.shared.setBool(LocalStorage.LocalValue.userCheckedOut, value: true)
            LocalStorage.shared.setBool(LocalStorage.LocalValue.isUserCheckedin, value: true)
            LocalStorage.shared.setBool(LocalStorage.LocalValue.didUserWindUP, value: true)
           
            configureFinalsubmit(false)
            configureAddCall(false)
            configureAddplanBtn(false)
        } else {
            reserCallModule(lastCheckinDate:  lastCheckinDate)
        }
    }
    
    func toReturnLastCheckinDate() -> Date? {
        var lastCheckinDate : Date?
        
        if let windedUps = toReturnWindedupDates() {
            for windedUp in windedUps {
                if let windedUpDate = windedUp.statusDate {
                    lastCheckinDate = windedUpDate
                }
            }
        }
        return lastCheckinDate
        
    }
}
