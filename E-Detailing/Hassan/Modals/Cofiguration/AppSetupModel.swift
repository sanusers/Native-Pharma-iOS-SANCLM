//
//  AppSetupModel.swift
//  E-Detailing
//
//  Created by San eforce on 08/11/23.
//

import Foundation



class NewAppSetupModel : Codable {
    
    var activityNeed : Int
    var androidApp : Int
    var androidDetailing : Int
    var apprMandatoryNeed : Int
    var approvalNeed : Int
    var attendance : Int
    var appDeviceId : String
    var callFeedEnterable : Int
    var callReport : String
    var callReportFromDate : String!
    var callReportToDate : String
    var chmAdQty : Int
    var chmSampleQtyNeed : Int
    var cipNeed : Int
    var circular : Int
    var cntRemarks : Int
    var currentDay : Int
    var ceNeed : Int
    var cfNeed : Int
    var cheBase :Int
    var ciNeed : Int
    var cipPobMdNeed : Int
    var cipPobNeed : Int
    var cipCaption : String
    var cipENeed : Int
    var cipFNeed : Int
    var cipINeed : Int
    var cipPNeed : Int
    var cipQNeed :Int
    var cipJointWrkNeed : Int
    var cpNeed : Int
    var cqNeed : Int
    var campNeed : Int
    var catNeed : Int
    var chmCap : String
    var chmEventMdNeed : Int
    var chmNeed : Int
    var chmQcap :String
    var chmRcpaCompetitorNeed : Int
    var chmRxQtyNeed : Int
    var chmSampleCap : String
    var chmInputCaption : String
    var chmPobMandatoryNeed : Int
    var chmPobNeed : Int
    var chmProductCaption : String
    var chmRcpaNeed : Int
    var chmClusterBased :Int
    var chmJointWrkMdNeed : Int
    var chmJointWrkNeed : Int
    var cipEventMdNeed : Int
    var cipSrtNd : Int
    var clusterCap : String
    var cmpgnNeed : Int
    var currentdayTpPlanned : Int
    var custSrtNeed : Int
    var deNeed : Int
    var dfNeed :Int
    var diNeed : Int
    var dpNeed : Int
    var dqNeed : Int
    var dsName : String
    var dcrLockDays : Int
    var dcrFirstSelfieNeed : Int
    var desig : String
    var detailingChem : Int
    var detailingType :Int
    var deviceIdNeed : Int
    var deviceRegId : String
    var disRad : String
    var divisionCode : String
    var dlyCtrl : Int
    var docInputCaption : String
    var docPobMandatoryNeed : Int
    var docPobNeed : Int
    var docProductCaption :String
    var docClusterBased : Int
    var docJointWrkMdNeed :Int
    var docJointWrkNeed : Int
    var docCap : String
    var docEventMdNeed : Int
    var docFeedMdNeed : Int
    var docInputMdNeed : Int
    var docNeed : Int
    var docProductMdNeed : Int
    var docRcpaCompetitorNeed : Int
    var docRcpaQMdNeed : Int
    var docRxNeed :Int
    var docRxQCap : String
    var docRxQMd :Int
    var docSampleNeed : Int
    var docSampleQCap : String
    var docSampleQMdNeed : Int
    var dashboard : Int
    var dayplanTpBased : Int
    var days : Int
    var dcrDocBusinessProduct : Int
    var desigCode : String
    var docBusinessProduct : Int
    var docBusinessValue : Int
    var doctorDobDow : Int
    var expenceNeed : Int
    var expenceMdNeed : Int
    var expenseNeed : Int
    var editHoliday : Int
    var editWeeklyOff : Int
    var entryformMgr : Int
    var entryFormNeed : Int
    var expense_Need : Int
    var faq : Int
    var geoTagNeed : Int
    var geoTagNeedChe : Int
    var geoTagNeedStock :Int
    var geoTagNeedUnList : Int
    var geoCheck :Int
    var geoNeed : Int
    var geoTagNeedCip : Int
    var gstOption : Int
    var geoTagImg : Int
    var heNeed : Int
    var hfNeed : Int
    var hiNeed : Int
    var hpNeed : Int
    var hqName : String
    var hqNeed :Int
    var hosPobMdNeed : Int
    var hosPobNeed :Int
    var hospEventNeed : Int
    var hospCaption : String
    var hospNeed : Int
    var inputValQty : Int
    var inputValidation : Int
    var leaveStatus : Int
    var leaveEntitlementNeed : Int
    var locationTrack : Int
    var iosApp : Int
    var iosDetailing : Int
    var mclDet : Int
    var mgrHlfDy : Int
    var mrHlfDy : Int
    var msdEntry :Int
    var mailNeed : Int
    var miscExpenseNeed : Int
    var missedDateMdNeed : Int
    var multiClusterNeed : Int
    var multipleDocNeed : Int
    var mydayplanNeed : Int
    var myPlnRmrksMand : Int
    var neNeed : Int
    var nfNeed :Int
    var niNeed : Int
    var nlCap : String
    var nlRxQCap : String
    var nlSampleQCap : String
    var npNeed : Int
    var nqNeed : Int
    var nextVst : Int
    var nextVstMdNeed : Int
    var noOfTpView :Int
    var orderCaption : String
    var orderManagement :Int
    var otherNeed : Int
    var primaryOrder : Int
    var primaryOrderCap : String
    var prodStkNeed : Int
    var productRateEditable : Int
    var pwdSetup : Int
    var pastLeavePost : Int
    var pobMinValue : Int
    var productFeedBack : Int
    var primarySecNeed : Int
    var proDetNeed : Int
    var prodDetNeed : Int
    var productRemarkNeed : Int
    var productRemarkMdNeed : Int
    var productPobNeed : Int
    var productPobNeedMsg : String
    var quesNeed : Int
    var quizHeading : String
    var quizNeed : Int
    var quizMandNeed : Int
    var quoteText : String
    var rcpaQtyNeed : Int
    var rcpaUnitNeed : Int
    var rcpaMdNeed :Int
    var rcpaMgrMdNeed : Int
    var rcpaNeed :Int
    var rcpaCompetitorExtra : Int
    var remainderCallCap : String
    var remainderGeo : Int
    var remainderProductMd : Int
    var rmdrNeed : Int
    var rcpaextra : Int
    var refDoc : Int
    var seNeed : Int
    var sfNeed : Int
    var sfStat : String
  //  var sfTpDate : Double
    var sfCode : String
    var sfName :String
    var sfPassword : String
    var sfUserName : String
    var sfEmail : String
    var sfMobile : String
    var sfEmpId : String
    var sfType : Int
    var stp : Int
    var siNeed : Int
    var spNeed : Int
    var sqNeed : Int
    var sampleValQty : Int
    var sampleValidation : Int
    var secondaryOrder : Int
    var secondaryOrderCaption : String
    var secondaryOrderDiscount : Int
    var sepRcpaNeed :Int
    var sequentailDcr : Int
    var srtNeed : Int
    var stateCode : Int
    var stkCap :String
    var stkEventMdNeed : Int
    var stkNeed :Int
    var stkQCap : String
    var stkInputCaption : String
    var stkPobMdNeed : Int
    var stkPobNeed : Int
    var stkProductCaption : String
    var stkClusterBased : Int
    var stkJointWrkMdNeed : Int
    var stkJointWrkNeed :Int
    var surveyNeed : Int
    var success : Int
    var subDivisionCode : String
    var tBase :Int
    var tpdcrDeviation : Int
    var tpdcrDeviationApprStatus : Int
    var tpdcrMgrAppr : Int
    var tpMdNeed : Int
    var tpBasedDcr : Int
    var targetReportNeed : Int
    var targetReportMdNeed : Int
    var taxNameCaption :String
    var tempNeed : Int
    var terrBasedTag :Int
    var terrotoryVisitNeed : Int
    var tpEndDate : Int
    var tpstartDate : Int
    var tpNeed : Int
    var tpnew : Int
    var trackingTime : String
    var travelDistanceNeed : Int
    var unlNeed : Int
    var ulDocClusterBased : Int
    var ulDocEventMd : Int
    var ulInputCaption : String
    var ulPobMdNeed :Int
    var ulPobNeed : Int
    var ulProductCaption :String
    var ulJointWrlMdNeed : Int
    var ulJointWrlNeed : Int
    var usrDfdUserName : String
    var visitNeed : Int
    var workAreaName : String
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activityNeed = try container.decode(Int.self, forKey: .activityNeed)
        self.androidApp = try container.decode(Int.self, forKey: .androidApp)
        self.androidDetailing = try container.decode(Int.self, forKey: .androidDetailing)
        self.apprMandatoryNeed = try container.decode(Int.self, forKey: .apprMandatoryNeed)
        self.approvalNeed = try container.decode(Int.self, forKey: .approvalNeed)
        self.attendance = try container.decode(Int.self, forKey: .attendance)
        self.appDeviceId = try container.decode(String.self, forKey: .appDeviceId)
        self.callFeedEnterable = try container.decode(Int.self, forKey: .callFeedEnterable)
        self.callReport = try container.decode(String.self, forKey: .callReport)
        self.callReportFromDate = try container.decodeIfPresent(String.self, forKey: .callReportFromDate)
        self.callReportToDate = try container.decode(String.self, forKey: .callReportToDate)
        self.chmAdQty = try container.decode(Int.self, forKey: .chmAdQty)
        self.chmSampleQtyNeed = try container.decode(Int.self, forKey: .chmSampleQtyNeed)
        self.cipNeed = try container.decode(Int.self, forKey: .cipNeed)
        self.circular = try container.decode(Int.self, forKey: .circular)
        self.cntRemarks = try container.decode(Int.self, forKey: .cntRemarks)
        self.currentDay = try container.decode(Int.self, forKey: .currentDay)
        self.ceNeed = try container.decode(Int.self, forKey: .ceNeed)
        self.cfNeed = try container.decode(Int.self, forKey: .cfNeed)
        self.cheBase = try container.decode(Int.self, forKey: .cheBase)
        self.ciNeed = try container.decode(Int.self, forKey: .ciNeed)
        self.cipPobMdNeed = try container.decode(Int.self, forKey: .cipPobMdNeed)
        self.cipPobNeed = try container.decode(Int.self, forKey: .cipPobNeed)
        self.cipCaption = try container.decode(String.self, forKey: .cipCaption)
        self.cipENeed = try container.decode(Int.self, forKey: .cipENeed)
        self.cipFNeed = try container.decode(Int.self, forKey: .cipFNeed)
        self.cipINeed = try container.decode(Int.self, forKey: .cipINeed)
        self.cipPNeed = try container.decode(Int.self, forKey: .cipPNeed)
        self.cipQNeed = try container.decode(Int.self, forKey: .cipQNeed)
        self.cipJointWrkNeed = try container.decode(Int.self, forKey: .cipJointWrkNeed)
        self.cpNeed = try container.decode(Int.self, forKey: .cpNeed)
        self.cqNeed = try container.decode(Int.self, forKey: .cqNeed)
        self.campNeed = try container.decode(Int.self, forKey: .campNeed)
        self.catNeed = try container.decode(Int.self, forKey: .catNeed)
        self.chmCap = try container.decode(String.self, forKey: .chmCap)
        self.chmEventMdNeed = try container.decode(Int.self, forKey: .chmEventMdNeed)
        self.chmNeed = try container.decode(Int.self, forKey: .chmNeed)
        self.chmQcap = try container.decode(String.self, forKey: .chmQcap)
        self.chmRcpaCompetitorNeed = try container.decode(Int.self, forKey: .chmRcpaCompetitorNeed)
        self.chmRxQtyNeed = try container.decode(Int.self, forKey: .chmRxQtyNeed)
        self.chmSampleCap = try container.decode(String.self, forKey: .chmSampleCap)
        self.chmInputCaption = try container.decode(String.self, forKey: .chmInputCaption)
        self.chmPobMandatoryNeed = try container.decode(Int.self, forKey: .chmPobMandatoryNeed)
        self.chmPobNeed = try container.decode(Int.self, forKey: .chmPobNeed)
        self.chmProductCaption = try container.decode(String.self, forKey: .chmProductCaption)
        self.chmRcpaNeed = try container.decode(Int.self, forKey: .chmRcpaNeed)
        self.chmClusterBased = try container.decode(Int.self, forKey: .chmClusterBased)
        self.chmJointWrkMdNeed = try container.decode(Int.self, forKey: .chmJointWrkMdNeed)
        self.chmJointWrkNeed = try container.decode(Int.self, forKey: .chmJointWrkNeed)
        self.cipEventMdNeed = try container.decode(Int.self, forKey: .cipEventMdNeed)
        self.cipSrtNd = try container.decode(Int.self, forKey: .cipSrtNd)
        self.clusterCap = try container.decode(String.self, forKey: .clusterCap)
        self.cmpgnNeed = try container.decode(Int.self, forKey: .cmpgnNeed)
        self.currentdayTpPlanned = try container.decode(Int.self, forKey: .currentdayTpPlanned)
        self.custSrtNeed = try container.decode(Int.self, forKey: .custSrtNeed)
        self.deNeed = try container.decode(Int.self, forKey: .deNeed)
        self.dfNeed = try container.decode(Int.self, forKey: .dfNeed)
        self.diNeed = try container.decode(Int.self, forKey: .diNeed)
        self.dpNeed = try container.decode(Int.self, forKey: .dpNeed)
        self.dqNeed = try container.decode(Int.self, forKey: .dqNeed)
        self.dsName = try container.decode(String.self, forKey: .dsName)
        self.dcrLockDays = try container.decode(Int.self, forKey: .dcrLockDays)
        self.dcrFirstSelfieNeed = try container.decode(Int.self, forKey: .dcrFirstSelfieNeed)
        self.desig = try container.decode(String.self, forKey: .desig)
        self.detailingChem = try container.decode(Int.self, forKey: .detailingChem)
        self.detailingType = try container.decode(Int.self, forKey: .detailingType)
        self.deviceIdNeed = try container.decode(Int.self, forKey: .deviceIdNeed)
        self.deviceRegId = try container.decode(String.self, forKey: .deviceRegId)
        self.disRad = try container.decode(String.self, forKey: .disRad)
        self.divisionCode = try container.decode(String.self, forKey: .divisionCode)
        self.dlyCtrl = try container.decode(Int.self, forKey: .dlyCtrl)
        self.docInputCaption = try container.decode(String.self, forKey: .docInputCaption)
        self.docPobMandatoryNeed = try container.decode(Int.self, forKey: .docPobMandatoryNeed)
        self.docPobNeed = try container.decode(Int.self, forKey: .docPobNeed)
        self.docProductCaption = try container.decode(String.self, forKey: .docProductCaption)
        self.docClusterBased = try container.decode(Int.self, forKey: .docClusterBased)
        self.docJointWrkMdNeed = try container.decode(Int.self, forKey: .docJointWrkMdNeed)
        self.docJointWrkNeed = try container.decode(Int.self, forKey: .docJointWrkNeed)
        self.docCap = try container.decode(String.self, forKey: .docCap)
        self.docEventMdNeed = try container.decode(Int.self, forKey: .docEventMdNeed)
        self.docFeedMdNeed = try container.decode(Int.self, forKey: .docFeedMdNeed)
        self.docInputMdNeed = try container.decode(Int.self, forKey: .docInputMdNeed)
        self.docNeed = try container.decode(Int.self, forKey: .docNeed)
        self.docProductMdNeed = try container.decode(Int.self, forKey: .docProductMdNeed)
        self.docRcpaCompetitorNeed = try container.decode(Int.self, forKey: .docRcpaCompetitorNeed)
        self.docRcpaQMdNeed = try container.decode(Int.self, forKey: .docRcpaQMdNeed)
        self.docRxNeed = try container.decode(Int.self, forKey: .docRxNeed)
        self.docRxQCap = try container.decode(String.self, forKey: .docRxQCap)
        self.docRxQMd = try container.decode(Int.self, forKey: .docRxQMd)
        self.docSampleNeed = try container.decode(Int.self, forKey: .docSampleNeed)
        self.docSampleQCap = try container.decode(String.self, forKey: .docSampleQCap)
        self.docSampleQMdNeed = try container.decode(Int.self, forKey: .docSampleQMdNeed)
        self.dashboard = try container.decode(Int.self, forKey: .dashboard)
        self.dayplanTpBased = try container.decode(Int.self, forKey: .dayplanTpBased)
        self.days = try container.decode(Int.self, forKey: .days)
        self.dcrDocBusinessProduct = try container.decode(Int.self, forKey: .dcrDocBusinessProduct)
        self.desigCode = try container.decode(String.self, forKey: .desigCode)
        self.docBusinessProduct = try container.decode(Int.self, forKey: .docBusinessProduct)
        self.docBusinessValue = try container.decode(Int.self, forKey: .docBusinessValue)
        self.doctorDobDow = try container.decode(Int.self, forKey: .doctorDobDow)
        self.expenceNeed = try container.decode(Int.self, forKey: .expenceNeed)
        self.expenceMdNeed = try container.decode(Int.self, forKey: .expenceMdNeed)
        self.expenseNeed = try container.decode(Int.self, forKey: .expenseNeed)
        self.editHoliday = try container.decode(Int.self, forKey: .editHoliday)
        self.editWeeklyOff = try container.decode(Int.self, forKey: .editWeeklyOff)
        self.entryformMgr = try container.decode(Int.self, forKey: .entryformMgr)
        self.entryFormNeed = try container.decode(Int.self, forKey: .entryFormNeed)
        self.expense_Need = try container.decode(Int.self, forKey: .expense_Need)
        self.faq = try container.decode(Int.self, forKey: .faq)
        self.geoTagNeed = try container.decode(Int.self, forKey: .geoTagNeed)
        self.geoTagNeedChe = try container.decode(Int.self, forKey: .geoTagNeedChe)
        self.geoTagNeedStock = try container.decode(Int.self, forKey: .geoTagNeedStock)
        self.geoTagNeedUnList = try container.decode(Int.self, forKey: .geoTagNeedUnList)
        self.geoCheck = try container.decode(Int.self, forKey: .geoCheck)
        self.geoNeed = try container.decode(Int.self, forKey: .geoNeed)
        self.geoTagNeedCip = try container.decode(Int.self, forKey: .geoTagNeedCip)
        self.gstOption = try container.decode(Int.self, forKey: .gstOption)
        self.geoTagImg = try container.decode(Int.self, forKey: .geoTagImg)
        self.heNeed = try container.decode(Int.self, forKey: .heNeed)
        self.hfNeed = try container.decode(Int.self, forKey: .hfNeed)
        self.hiNeed = try container.decode(Int.self, forKey: .hiNeed)
        self.hpNeed = try container.decode(Int.self, forKey: .hpNeed)
        self.hqName = try container.decode(String.self, forKey: .hqName)
        self.hqNeed = try container.decode(Int.self, forKey: .hqNeed)
        self.hosPobMdNeed = try container.decode(Int.self, forKey: .hosPobMdNeed)
        self.hosPobNeed = try container.decode(Int.self, forKey: .hosPobNeed)
        self.hospEventNeed = try container.decode(Int.self, forKey: .hospEventNeed)
        self.hospCaption = try container.decode(String.self, forKey: .hospCaption)
        self.hospNeed = try container.decode(Int.self, forKey: .hospNeed)
        self.inputValQty = try container.decode(Int.self, forKey: .inputValQty)
        self.inputValidation = try container.decode(Int.self, forKey: .inputValidation)
        self.leaveStatus = try container.decode(Int.self, forKey: .leaveStatus)
        self.leaveEntitlementNeed = try container.decode(Int.self, forKey: .leaveEntitlementNeed)
        self.locationTrack = try container.decode(Int.self, forKey: .locationTrack)
        self.iosApp = try container.decode(Int.self, forKey: .iosApp)
        self.iosDetailing = try container.decode(Int.self, forKey: .iosDetailing)
        self.mclDet = try container.decode(Int.self, forKey: .mclDet)
        self.mgrHlfDy = try container.decode(Int.self, forKey: .mgrHlfDy)
        self.mrHlfDy = try container.decode(Int.self, forKey: .mrHlfDy)
        self.msdEntry = try container.decode(Int.self, forKey: .msdEntry)
        self.mailNeed = try container.decode(Int.self, forKey: .mailNeed)
        self.miscExpenseNeed = try container.decode(Int.self, forKey: .miscExpenseNeed)
        self.missedDateMdNeed = try container.decode(Int.self, forKey: .missedDateMdNeed)
        self.multiClusterNeed = try container.decode(Int.self, forKey: .multiClusterNeed)
        self.multipleDocNeed = try container.decode(Int.self, forKey: .multipleDocNeed)
        self.mydayplanNeed = try container.decode(Int.self, forKey: .mydayplanNeed)
        self.myPlnRmrksMand = try container.decode(Int.self, forKey: .myPlnRmrksMand)
        self.neNeed = try container.decode(Int.self, forKey: .neNeed)
        self.nfNeed = try container.decode(Int.self, forKey: .nfNeed)
        self.niNeed = try container.decode(Int.self, forKey: .niNeed)
        self.nlCap = try container.decode(String.self, forKey: .nlCap)
        self.nlRxQCap = try container.decode(String.self, forKey: .nlRxQCap)
        self.nlSampleQCap = try container.decode(String.self, forKey: .nlSampleQCap)
        self.npNeed = try container.decode(Int.self, forKey: .npNeed)
        self.nqNeed = try container.decode(Int.self, forKey: .nqNeed)
        self.nextVst = try container.decode(Int.self, forKey: .nextVst)
        self.nextVstMdNeed = try container.decode(Int.self, forKey: .nextVstMdNeed)
        self.noOfTpView = try container.decode(Int.self, forKey: .noOfTpView)
        self.orderCaption = try container.decode(String.self, forKey: .orderCaption)
        self.orderManagement = try container.decode(Int.self, forKey: .orderManagement)
        self.otherNeed = try container.decode(Int.self, forKey: .otherNeed)
        self.primaryOrder = try container.decode(Int.self, forKey: .primaryOrder)
        self.primaryOrderCap = try container.decode(String.self, forKey: .primaryOrderCap)
        self.prodStkNeed = try container.decode(Int.self, forKey: .prodStkNeed)
        self.productRateEditable = try container.decode(Int.self, forKey: .productRateEditable)
        self.pwdSetup = try container.decode(Int.self, forKey: .pwdSetup)
        self.pastLeavePost = try container.decode(Int.self, forKey: .pastLeavePost)
        self.pobMinValue = try container.decode(Int.self, forKey: .pobMinValue)
        self.productFeedBack = try container.decode(Int.self, forKey: .productFeedBack)
        self.primarySecNeed = try container.decode(Int.self, forKey: .primarySecNeed)
        self.proDetNeed = try container.decode(Int.self, forKey: .proDetNeed)
        self.prodDetNeed = try container.decode(Int.self, forKey: .prodDetNeed)
        self.productRemarkNeed = try container.decode(Int.self, forKey: .productRemarkNeed)
        self.productRemarkMdNeed = try container.decode(Int.self, forKey: .productRemarkMdNeed)
        self.productPobNeed = try container.decode(Int.self, forKey: .productPobNeed)
        self.productPobNeedMsg = try container.decode(String.self, forKey: .productPobNeedMsg)
        self.quesNeed = try container.decode(Int.self, forKey: .quesNeed)
        self.quizHeading = try container.decode(String.self, forKey: .quizHeading)
        self.quizNeed = try container.decode(Int.self, forKey: .quizNeed)
        self.quizMandNeed = try container.decode(Int.self, forKey: .quizMandNeed)
        self.quoteText = try container.decode(String.self, forKey: .quoteText)
        self.rcpaQtyNeed = try container.decode(Int.self, forKey: .rcpaQtyNeed)
        self.rcpaUnitNeed = try container.decode(Int.self, forKey: .rcpaUnitNeed)
        self.rcpaMdNeed = try container.decode(Int.self, forKey: .rcpaMdNeed)
        self.rcpaMgrMdNeed = try container.decode(Int.self, forKey: .rcpaMgrMdNeed)
        self.rcpaNeed = try container.decode(Int.self, forKey: .rcpaNeed)
        self.rcpaCompetitorExtra = try container.decode(Int.self, forKey: .rcpaCompetitorExtra)
        self.remainderCallCap = try container.decode(String.self, forKey: .remainderCallCap)
        self.remainderGeo = try container.decode(Int.self, forKey: .remainderGeo)
        self.remainderProductMd = try container.decode(Int.self, forKey: .remainderProductMd)
        self.rmdrNeed = try container.decode(Int.self, forKey: .rmdrNeed)
        self.rcpaextra = try container.decode(Int.self, forKey: .rcpaextra)
        self.refDoc = try container.decode(Int.self, forKey: .refDoc)
        self.seNeed = try container.decode(Int.self, forKey: .seNeed)
        self.sfNeed = try container.decode(Int.self, forKey: .sfNeed)
        self.sfStat = try container.decode(String.self, forKey: .sfStat)
      //  self.sfTpDate = try container.decode(Double.self, forKey: .sfTpDate)
        self.sfCode = try container.decode(String.self, forKey: .sfCode)
        self.sfName = try container.decode(String.self, forKey: .sfName)
        self.sfPassword = try container.decode(String.self, forKey: .sfPassword)
        self.sfUserName = try container.decode(String.self, forKey: .sfUserName)
        self.sfEmail = try container.decode(String.self, forKey: .sfEmail)
        self.sfMobile = try container.decode(String.self, forKey: .sfMobile)
        self.sfEmpId = try container.decode(String.self, forKey: .sfEmpId)
        self.sfType = try container.decode(Int.self, forKey: .sfType)
        self.stp = try container.decode(Int.self, forKey: .stp)
        self.siNeed = try container.decode(Int.self, forKey: .siNeed)
        self.spNeed = try container.decode(Int.self, forKey: .spNeed)
        self.sqNeed = try container.decode(Int.self, forKey: .sqNeed)
        self.sampleValQty = try container.decode(Int.self, forKey: .sampleValQty)
        self.sampleValidation = try container.decode(Int.self, forKey: .sampleValidation)
        self.secondaryOrder = try container.decode(Int.self, forKey: .secondaryOrder)
        self.secondaryOrderCaption = try container.decode(String.self, forKey: .secondaryOrderCaption)
        self.secondaryOrderDiscount = try container.decode(Int.self, forKey: .secondaryOrderDiscount)
        self.sepRcpaNeed = try container.decode(Int.self, forKey: .sepRcpaNeed)
        self.sequentailDcr = try container.decode(Int.self, forKey: .sequentailDcr)
        self.srtNeed = try container.decode(Int.self, forKey: .srtNeed)
        self.stateCode = try container.decode(Int.self, forKey: .stateCode)
        self.stkCap = try container.decode(String.self, forKey: .stkCap)
        self.stkEventMdNeed = try container.decode(Int.self, forKey: .stkEventMdNeed)
        self.stkNeed = try container.decode(Int.self, forKey: .stkNeed)
        self.stkQCap = try container.decode(String.self, forKey: .stkQCap)
        self.stkInputCaption = try container.decode(String.self, forKey: .stkInputCaption)
        self.stkPobMdNeed = try container.decode(Int.self, forKey: .stkPobMdNeed)
        self.stkPobNeed = try container.decode(Int.self, forKey: .stkPobNeed)
        self.stkProductCaption = try container.decode(String.self, forKey: .stkProductCaption)
        self.stkClusterBased = try container.decode(Int.self, forKey: .stkClusterBased)
        self.stkJointWrkMdNeed = try container.decode(Int.self, forKey: .stkJointWrkMdNeed)
        self.stkJointWrkNeed = try container.decode(Int.self, forKey: .stkJointWrkNeed)
        self.surveyNeed = try container.decode(Int.self, forKey: .surveyNeed)
        self.success = try container.decode(Int.self, forKey: .success)
        self.subDivisionCode = try container.decode(String.self, forKey: .subDivisionCode)
        self.tBase = try container.decode(Int.self, forKey: .tBase)
        self.tpdcrDeviation = try container.decode(Int.self, forKey: .tpdcrDeviation)
        self.tpdcrDeviationApprStatus = try container.decode(Int.self, forKey: .tpdcrDeviationApprStatus)
        self.tpdcrMgrAppr = try container.decode(Int.self, forKey: .tpdcrMgrAppr)
        self.tpMdNeed = try container.decode(Int.self, forKey: .tpMdNeed)
        self.tpBasedDcr = try container.decode(Int.self, forKey: .tpBasedDcr)
        self.targetReportNeed = try container.decode(Int.self, forKey: .targetReportNeed)
        self.targetReportMdNeed = try container.decode(Int.self, forKey: .targetReportMdNeed)
        self.taxNameCaption = try container.decode(String.self, forKey: .taxNameCaption)
        self.tempNeed = try container.decode(Int.self, forKey: .tempNeed)
        self.terrBasedTag = try container.decode(Int.self, forKey: .terrBasedTag)
        self.terrotoryVisitNeed = try container.decode(Int.self, forKey: .terrotoryVisitNeed)
        self.tpEndDate = try container.decode(Int.self, forKey: .tpEndDate)
        self.tpstartDate = try container.decode(Int.self, forKey: .tpstartDate)
        self.tpNeed = try container.decode(Int.self, forKey: .tpNeed)
        self.tpnew = try container.decode(Int.self, forKey: .tpnew)
        self.trackingTime = try container.decode(String.self, forKey: .trackingTime)
        self.travelDistanceNeed = try container.decode(Int.self, forKey: .travelDistanceNeed)
        self.unlNeed = try container.decode(Int.self, forKey: .unlNeed)
        self.ulDocClusterBased = try container.decode(Int.self, forKey: .ulDocClusterBased)
        self.ulDocEventMd = try container.decode(Int.self, forKey: .ulDocEventMd)
        self.ulInputCaption = try container.decode(String.self, forKey: .ulInputCaption)
        self.ulPobMdNeed = try container.decode(Int.self, forKey: .ulPobMdNeed)
        self.ulPobNeed = try container.decode(Int.self, forKey: .ulPobNeed)
        self.ulProductCaption = try container.decode(String.self, forKey: .ulProductCaption)
        self.ulJointWrlMdNeed = try container.decode(Int.self, forKey: .ulJointWrlMdNeed)
        self.ulJointWrlNeed = try container.decode(Int.self, forKey: .ulJointWrlNeed)
        self.usrDfdUserName = try container.decode(String.self, forKey: .usrDfdUserName)
        self.visitNeed = try container.decode(Int.self, forKey: .visitNeed)
        self.workAreaName = try container.decode(String.self, forKey: .workAreaName)
    }
    
    enum CodingKeys: String, CodingKey {
        case activityNeed = "ActivityNd"
        case androidApp = "Android_App"
        case androidDetailing = "Android_Detailing"
        case apprMandatoryNeed = "Appr_Mandatory_Need"
        case approvalNeed = "Approveneed"
        case attendance = "Attendance"
        case appDeviceId = "app_device_id"
        case callFeedEnterable = "call_feed_enterable"
        case callReport = "call_report"
        case callReportFromDate = "call_report_from_date"
        case callReportToDate = "call_report_to_date"
        case chmAdQty = "chm_ad_qty"
        case chmSampleQtyNeed = "chmsamQty_need"
        case cipNeed = "cip_need"
        case circular = "circular"
        case cntRemarks = "cntRemarks"
        case currentDay = "currentDay"
        case ceNeed = "CENeed"
        case cfNeed = "CFNeed"
        case cheBase = "CHEBase"
        case ciNeed = "CINeed"
        case cipPobMdNeed = "CIPPOBMd"
        case cipPobNeed = "CIPPOBNd"
        case cipCaption = "CIP_Caption"
        case cipENeed = "CIP_ENeed"
        case cipFNeed = "CIP_FNeed"
        case cipINeed = "CIP_INeed"
        case cipPNeed = "CIP_PNeed"
        case cipQNeed = "CIP_QNeed"
        case cipJointWrkNeed = "CIP_jointwork_Need"
        case cpNeed = "CPNeed"
        case cqNeed = "CQNeed"
        case campNeed = "Campneed"
        case catNeed = "Catneed"
        case chmCap = "ChmCap"
        case chmEventMdNeed = "ChmEvent_Md"
        case chmNeed = "ChmNeed"
        case chmQcap = "ChmQCap"
        case chmRcpaCompetitorNeed = "ChmRCPA_competitor_Need"
        case chmRxQtyNeed = "ChmRxQty"
        case chmSampleCap = "ChmSmpCap"
        case chmInputCaption = "Chm_Input_caption"
        case chmPobMandatoryNeed = "Chm_Pob_Mandatory_Need"
        case chmPobNeed = "Chm_Pob_Need"
        case chmProductCaption = "Chm_Product_caption"
        case chmRcpaNeed = "Chm_RCPA_Need"
        case chmClusterBased = "Chm_cluster_based"
        case chmJointWrkMdNeed = "Chm_jointwork_Mandatory_Need"
        case chmJointWrkNeed = "Chm_jointwork_Need"
        case cipEventMdNeed = "CipEvent_Md"
        case cipSrtNd = "CipSrtNd"
        case clusterCap = "Cluster_Cap"
        case cmpgnNeed = "CmpgnNeed"
        case currentdayTpPlanned = "Currentday_TPplanned"
        case custSrtNeed = "CustSrtNd"
        case deNeed = "DENeed"
        case dfNeed = "DFNeed"
        case diNeed = "DINeed"
        case dpNeed = "DPNeed"
        case dqNeed = "DQNeed"
        case dsName = "DS_name"
        case dcrLockDays = "DcrLockDays"
        case dcrFirstSelfieNeed = "Dcr_firstselfie"
        case desig = "Desig"
        case detailingChem = "Detailing_chem"
        case detailingType = "Detailing_type"
        case deviceIdNeed = "DeviceId_Need"
        case deviceRegId = "DeviceRegId"
        case disRad = "DisRad"
        case divisionCode = "Division_Code"
        case dlyCtrl = "DlyCtrl"
        case docInputCaption = "Doc_Input_caption"
        case docPobMandatoryNeed = "Doc_Pob_Mandatory_Need"
        case docPobNeed = "Doc_Pob_Need"
        case docProductCaption = "Doc_Product_caption"
        case docClusterBased = "Doc_cluster_based"
        case docJointWrkMdNeed = "Doc_jointwork_Mandatory_Need"
        case docJointWrkNeed = "Doc_jointwork_Need"
        case docCap = "DrCap"
        case docEventMdNeed = "DrEvent_Md"
        case docFeedMdNeed = "DrFeedMd"
        case docInputMdNeed = "DrInpMd"
        case docNeed = "DrNeed"
        case docProductMdNeed = "DrPrdMd"
        case docRcpaCompetitorNeed = "DrRCPA_competitor_Need"
        case docRcpaQMdNeed = "DrRcpaQMd"
        case docRxNeed = "DrRxNd"
        case docRxQCap = "DrRxQCap"
        case docRxQMd = "DrRxQMd"
        case docSampleNeed = "DrSampNd"
        case docSampleQCap = "DrSmpQCap"
        case docSampleQMdNeed = "DrSmpQMd"
        case dashboard = "dashboard"
        case dayplanTpBased = "dayplan_tp_based"
        case days = "days"
        case dcrDocBusinessProduct = "dcr_doc_business_product"
        case desigCode = "desig_Code"
        case docBusinessProduct = "doc_business_product"
        case docBusinessValue = "doc_business_value"
        case doctorDobDow = "doctor_dobdow"
        case expenceNeed = "ExpenceNd"
        case expenceMdNeed = "ExpenceNd_mandatory"
        case expenseNeed = "Expenseneed"
        case editHoliday = "edit_holiday"
        case editWeeklyOff = "edit_weeklyoff"
        case entryformMgr = "entryFormMgr"
        case entryFormNeed = "entryFormNeed"
        case expense_Need = "expense_need"
        case faq = "faq"
        case geoTagNeed = "GEOTagNeed"
        case geoTagNeedChe = "GEOTagNeedche"
        case geoTagNeedStock = "GEOTagNeedstock"
        case geoTagNeedUnList = "GEOTagNeedunlst"
        case geoCheck = "GeoChk"
        case geoNeed = "GeoNeed"
        case geoTagNeedCip = "GeoTagNeedcip"
        case gstOption = "Gst_option"
        case geoTagImg = "geoTagImg"
        case heNeed = "HENeed"
        case hfNeed = "HFNeed"
        case hiNeed = "HINeed"
        case hpNeed = "HPNeed"
        case hqName = "HQName"
        case hqNeed = "HQNeed"
        case hosPobMdNeed = "HosPOBMd"
        case hosPobNeed = "HosPOBNd"
        case hospEventNeed = "HospEvent_Md"
        case hospCaption = "hosp_caption"
        case hospNeed = "hosp_need"
        case inputValQty = "Input_Val_Qty"
        case inputValidation = "input_validation"
        case leaveStatus = "LeaveStatus"
        case leaveEntitlementNeed = "Leave_entitlement_need"
        case locationTrack = "Location_track"
        case iosApp = "ios_app"
        case iosDetailing = "ios_Detailing"
        case mclDet = "MCLDet"
        case mgrHlfDy = "MGRHlfDy"
        case mrHlfDy = "MRHlfDy"
        case msdEntry = "MsdEntry"
        case mailNeed = "mailneed"
        case miscExpenseNeed = "misc_expense_need"
        case missedDateMdNeed = "missedDateMand"
        case multiClusterNeed = "multi_cluster"
        case multipleDocNeed = "multiple_doc_need"
        case mydayplanNeed = "mydayplan_need"
        case myPlnRmrksMand = "myplnRmrksMand"
        case neNeed = "NENeed"
        case nfNeed = "NFNeed"
        case niNeed = "NINeed"
        case nlCap = "NLCap"
        case nlRxQCap = "NLRxQCap"
        case nlSampleQCap = "NLSmpQCap"
        case npNeed = "NPNeed"
        case nqNeed = "NQNeed"
        case nextVst = "NextVst"
        case nextVstMdNeed = "NextVst_Mandatory_Need"
        case noOfTpView = "No_of_TP_View"
        case orderCaption = "Order_caption"
        case orderManagement = "Order_management"
        case otherNeed = "OtherNd"
        case primaryOrder = "Primary_order"
        case primaryOrderCap = "Primary_order_caption"
        case prodStkNeed = "Prod_Stk_Need"
        case productRateEditable = "Product_Rate_Editable"
        case pwdSetup = "Pwdsetup"
        case pastLeavePost = "past_leave_post"
        case pobMinValue = "pob_minvalue"
        case productFeedBack = "prdfdback"
        case primarySecNeed = "primarysec_need"
        case proDetNeed = "pro_det_need"
        case prodDetNeed = "prod_det_need"
        case productRemarkNeed = "prod_remark"
        case productRemarkMdNeed = "prod_remark_md"
        case productPobNeed = "product_pob_need"
        case productPobNeedMsg = "product_pob_need_msg"
        case quesNeed = "ques_need"
        case quizHeading = "quiz_heading"
        case quizNeed = "quiz_need"
        case quizMandNeed = "quiz_need_mandt"
        case quoteText = "quote_Text"
        case rcpaQtyNeed = "RCPAQty_Need"
        case rcpaUnitNeed = "RCPA_unit_nd"
        case rcpaMdNeed = "RcpaMd"
        case rcpaMgrMdNeed = "RcpaMd_Mgr"
        case rcpaNeed = "RcpaNd"
        case rcpaCompetitorExtra = "Rcpa_Competitor_extra"
        case remainderCallCap = "Remainder_call_cap"
        case remainderGeo = "Remainder_geo"
        case remainderProductMd = "Remainder_prd_Md"
        case rmdrNeed = "RmdrNeed"
        case rcpaextra = "rcpaextra"
        case refDoc = "refDoc"
        case seNeed = "SENeed"
        case sfNeed = "SFNeed"
        case sfStat = "SFStat"
     //   case sfTpDate = "SFTPDate"
        case sfCode = "SF_Code"
        case sfName = "SF_Name"
        case sfPassword = "SF_Password"
        case sfUserName = "SF_User_Name"
        case sfEmail = "sfEmail"
        case sfMobile = "sfMobile"
        case sfEmpId = "sf_emp_id"
        case sfType = "sf_type"
        case stp = "stp"
        case siNeed = "SINeed"
        case spNeed = "SPNeed"
        case sqNeed = "SQNeed"
        case sampleValQty = "Sample_Val_Qty"
        case sampleValidation = "sample_validation"
        case secondaryOrder = "Secondary_order"
        case secondaryOrderCaption = "Secondary_order_caption"
        case secondaryOrderDiscount = "secondary_order_discount"
        case sepRcpaNeed = "Sep_RcpaNd"
        case sequentailDcr = "sequential_dcr"
        case srtNeed = "SrtNd"
        case stateCode = "State_Code"
        case stkCap = "StkCap"
        case stkEventMdNeed = "StkEvent_Md"
        case stkNeed = "StkNeed"
        case stkQCap = "StkQCap"
        case stkInputCaption = "Stk_Input_caption"
        case stkPobMdNeed = "Stk_Pob_Mandatory_Need"
        case stkPobNeed = "Stk_Pob_Need"
        case stkProductCaption = "Stk_Product_caption"
        case stkClusterBased = "Stk_cluster_based"
        case stkJointWrkMdNeed = "Stk_jointwork_Mandatory_Need"
        case stkJointWrkNeed = "Stk_jointwork_Need"
        case surveyNeed = "SurveyNd"
        case success = "success"
        case subDivisionCode = "subdivision_code"
        case tBase = "TBase"
        case tpdcrDeviation = "TPDCR_Deviation"
        case tpdcrDeviationApprStatus = "TPDCR_Deviation_Appr_Status"
        case tpdcrMgrAppr = "TPDCR_MGRAppr"
        case tpMdNeed = "TP_Mandatory_Need"
        case tpBasedDcr = "TPbasedDCR"
        case targetReportNeed = "Target_report_Nd"
        case targetReportMdNeed = "Target_report_md"
        case taxNameCaption = "Taxname_caption"
        case tempNeed = "TempNd"
        case terrBasedTag = "Terr_based_Tag"
        case terrotoryVisitNeed = "Territory_VstNd"
        case tpEndDate = "Tp_End_Date"
        case tpstartDate = "Tp_Start_Date"
        case tpNeed = "tp_need"
        case tpnew = "tp_new"
        case trackingTime = "tracking_time"
        case travelDistanceNeed = "travelDistance_Need"
        case unlNeed = "UNLNeed"
        case ulDocClusterBased = "UlDoc_cluster_based"
        case ulDocEventMd = "UlDrEvent_Md"
        case ulInputCaption = "Ul_Input_caption"
        case ulPobMdNeed = "Ul_Pob_Mandatory_Need"
        case ulPobNeed = "Ul_Pob_Need"
        case ulProductCaption = "Ul_Product_caption"
        case ulJointWrlMdNeed = "Ul_jointwork_Mandatory_Need"
        case ulJointWrlNeed = "Ul_jointwork_Need"
        case usrDfdUserName = "UsrDfd_UserName"
        case visitNeed = "VstNd"
        case workAreaName = "wrk_area_Name"
    }
    
}
