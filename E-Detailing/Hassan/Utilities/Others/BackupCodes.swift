//
//CoreDataManager.shared.tofetchaSavedCalls(callID: self.dcrCall.code) { addedDCRcall in
//    
//    
//    
//    dump(addedDCRcall)
//    
//    
//    let context = self.context
//    let ftchedDCRcall = addedDCRcall?.first
//    
//    //[AdditionalCallViewModel]
//    //Additional call
//    let aAdditionalcallVM =     AdditionalCallsListViewModel()
//    
//    if let additionalCallEntityDescription  = NSEntityDescription.entity(forEntityName: "AdditionalCallViewModelCDEntity", in: context) {
//        let additionalCallCDEntity = ftchedDCRcall?.additionalCallViewModel ?? AdditionalCallViewModelCDEntity(entity: additionalCallEntityDescription, insertInto: context)
//        
//        
//        
//        
//        if let addedAdditionalCall = additionalCallCDEntity.additionalCallViewModel {
//            addedAdditionalCall.forEach { additionalCallCDModel in
//                if let additionalCallCDModel = additionalCallCDModel as? AdditionalCallCDModel {
//                    let aAdditionalCall = AdditionalCallViewModel(additionalCall: nil, isView: false)
//                    aAdditionalCall.additionalCall = additionalCallCDModel.additionalCall
//                    if let productViewModelEntityDescription  = NSEntityDescription.entity(forEntityName: "ProductViewModelCDEntity", in: context) {
//                        
//                        let productSelectedListViewModel = ProductSelectedListViewModel()
//                        var productViewModelArr = [ProductViewModel]()
//                        
//                        let productSelectedListViewModelntity = additionalCallCDModel.productSelectedListViewModel ?? ProductViewModelCDEntity(entity: productViewModelEntityDescription, insertInto: context)
//                        if let productViewModelEntityArr = productSelectedListViewModelntity.productViewModelArr {
//                            productViewModelEntityArr.forEach({ productDataCDModel in
//                                if let productDataCDModel = productDataCDModel as? ProductDataCDModel {
//                                    var aProductData = ProductData(isDetailed: false, sampleCount: "", rxCount: "", rcpaCount: "", availableCount: "", totalCount: "", stockistName: "", stockistCode: "")
//                                    
//                                    
//                                    aProductData.isDetailed = productDataCDModel.isDetailed
//                                    aProductData.sampleCount = productDataCDModel.sampleCount ?? ""
//                                    aProductData.rxCount = productDataCDModel.rxCount ?? ""
//                                    aProductData.rcpaCount = productDataCDModel.rcpaCount ?? ""
//                                    aProductData.availableCount = productDataCDModel.availableCount ?? ""
//                                    aProductData.totalCount = productDataCDModel.totalCount ?? ""
//                                    aProductData.stockistName = productDataCDModel.stockistName ?? ""
//                                    aProductData.stockistCode = productDataCDModel.stockistCode ?? ""
//                                    
//                                    aProductData.product =  productDataCDModel.product
//                                    
//                                    let aproductViewModel = ProductViewModel(product: aProductData)
//                                    
//                                    productViewModelArr.append(aproductViewModel)
//                                }
//                            })
//                            productSelectedListViewModel.productViewModel = productViewModelArr
//                        }
//                        aAdditionalCall.productSelectedListViewModel = productSelectedListViewModel
//                    }
//                    
//                    
//                    
//                    
//                    if let inputViewModelEntityDescription  = NSEntityDescription.entity(forEntityName: "InputViewModelCDEntity", in: context) {
//                        let inputSelectedListViewModelEntity = additionalCallCDModel.inputSelectedListViewModel ?? InputViewModelCDEntity(entity: inputViewModelEntityDescription, insertInto: context)
//                        let inputSelectedListViewModel = InputSelectedListViewModel()
//                        var inputViewModelArr = [InputViewModel]()
//                        
//                        if let inputViewModelEntityArr = inputSelectedListViewModelEntity.inputViewModelArr {
//                            inputViewModelEntityArr.forEach({ inputDataCDModel in
//                                if let inputDataCDModel = inputDataCDModel as? InputDataCDModel {
//                                    
//                                    var  aInputData = InputData(availableCount: "", inputCount: "")
//                                    aInputData.availableCount = inputDataCDModel.availableCount ?? ""
//                                    aInputData.inputCount = inputDataCDModel.inputCount ?? ""
//                                    aInputData.input = inputDataCDModel.input
//                                    let inputViewModel = InputViewModel(input: aInputData)
//                                    inputViewModelArr.append(inputViewModel)
//                                    
//                                }
//                            })
//                            inputSelectedListViewModel.inputViewModel = inputViewModelArr
//                        }
//                        
//                        aAdditionalCall.inputSelectedListViewModel = inputSelectedListViewModel
//                    }
//                    
//                    
//                    if let inpuEntityDescription  = NSEntityDescription.entity(forEntityName: "InputDataCDModel", in: context) {
//                        _ = additionalCallCDModel.inputs ?? InputDataCDModel(entity: inpuEntityDescription, insertInto: context)
//                        
//                        var inputs  = [InputViewModel]()
//                        
//                        if let  inputDataCDModelArr = additionalCallCDModel.inputs {
//                            inputDataCDModelArr.forEach { inputDataCDModel in
//                                if let inputDataCDModel = inputDataCDModel as? InputDataCDModel {
//                                    
//                                    var  aInputData = InputData(availableCount: "", inputCount: "")
//                                    aInputData.availableCount = inputDataCDModel.availableCount ?? ""
//                                    aInputData.inputCount = inputDataCDModel.inputCount ?? ""
//                                    aInputData.input = inputDataCDModel.input
//                                    
//                                    
//                                    let ainput = InputViewModel(input: aInputData)
//                                    inputs.append(ainput)
//                                }
//                            }
//                        }
//                        aAdditionalCall.inputs = inputs
//                    }
//                    
//                    
//                    if let productEntityDescription  = NSEntityDescription.entity(forEntityName: "ProductDataCDModel", in: context) {
//                        _ = additionalCallCDModel.products ?? ProductDataCDModel(entity: productEntityDescription, insertInto: context)
//                        
//                        var products = [ProductViewModel]()
//                        
//                        if let  productDataCDModelArr = additionalCallCDModel.products {
//                            
//                            productDataCDModelArr.forEach { productDataCDModel in
//                                if let productDataCDModel = productDataCDModel as? ProductDataCDModel {
//                                    var aProductData = ProductData(isDetailed: false, sampleCount: "", rxCount: "", rcpaCount: "", availableCount: "", totalCount: "", stockistName: "", stockistCode: "")
//                                    
//                                    
//                                    aProductData.isDetailed = productDataCDModel.isDetailed
//                                    aProductData.sampleCount = productDataCDModel.sampleCount ?? ""
//                                    aProductData.rxCount = productDataCDModel.rxCount ?? ""
//                                    aProductData.rcpaCount = productDataCDModel.rcpaCount ?? ""
//                                    aProductData.availableCount = productDataCDModel.availableCount ?? ""
//                                    aProductData.totalCount = productDataCDModel.totalCount ?? ""
//                                    aProductData.stockistName = productDataCDModel.stockistName ?? ""
//                                    aProductData.stockistCode = productDataCDModel.stockistCode ?? ""
//                                    
//                                    aProductData.product =  productDataCDModel.product
//                                    
//                                    let aproductViewModel = ProductViewModel(product: aProductData)
//                                    
//                                    products.append(aproductViewModel)
//                                }
//                            }
//                            
//                        }
//                        aAdditionalCall.products = products
//                    }
//                    
//                    
//                    aAdditionalcallVM.addAdditionalCallViewModel(aAdditionalCall)
//                }
//            }
//        }
//
//        vc.additionalCallListViewModel = aAdditionalcallVM
//        
//    }
//    
//    //feecback
//    if let userfeedback  =  ftchedDCRcall?.overAllFeedBack {
//        if let entityDescription = NSEntityDescription.entity(forEntityName: "Feedback", in: context) {
//            let aFeedback = Feedback(entity: entityDescription, insertInto: context)
//            aFeedback.name = userfeedback.name
//            aFeedback.id = userfeedback.id
//            aFeedback.index = userfeedback.index
//            vc.overallFeedback = aFeedback
//        }
//    }
//
//    //remarks || pob
//    if let rematksValue  =  ftchedDCRcall?.overallRemarks {
//        vc.overallRemarks = rematksValue
//    }
//    
//    if let pobValue  =  ftchedDCRcall?.pobValue {
//        vc.pobValue = pobValue
//    }
//    
//    
//    
//    //Input
//    if let inputEntityDescription  = NSEntityDescription.entity(forEntityName: "InputViewModelCDEntity", in: context) {
//        let inputDetailsCDEntity = ftchedDCRcall?.inputViewModel ?? InputViewModelCDEntity(entity: inputEntityDescription, insertInto: context)
//        
//        let inputSelectedListViewModel = InputSelectedListViewModel()
//        inputSelectedListViewModel.uuid = inputDetailsCDEntity.uuid
//        
//        var inputViewModelArr =  [InputViewModel]()
//        if let inputViewModelCDArr = inputDetailsCDEntity.inputViewModelArr {
//            inputViewModelCDArr.forEach { inputDataCDModel in
//                var aProductData = InputData(availableCount: "", inputCount: "")
//                if let ainputDataCDModel = inputDataCDModel as? InputDataCDModel {
//                  
//                    aProductData.availableCount = ainputDataCDModel.availableCount ?? ""
//                    aProductData.inputCount = ainputDataCDModel.inputCount ?? ""
//                    aProductData.input = ainputDataCDModel.input
//                    
//                  let inputViewModel = InputViewModel(input: aProductData)
//                  inputViewModelArr.append(inputViewModel)
//                }
//            }
//        }
//        inputSelectedListViewModel.inputViewModel = inputViewModelArr
//        vc.inputSelectedListViewModel = inputSelectedListViewModel
//    }
//    
//    //Product
//    if let producEntityDescription  = NSEntityDescription.entity(forEntityName: "ProductViewModelCDEntity", in: context) {
//        let productDetailsCDEntity = ftchedDCRcall?.productViewModel ?? ProductViewModelCDEntity(entity: producEntityDescription, insertInto: context)
//        ///ProductSelectedListViewModel
//        
//        let productSelectedListViewModel = ProductSelectedListViewModel()
//        productSelectedListViewModel.uuid = productDetailsCDEntity.uuid
//        
//        
//        var productViewModelArr =  [ProductViewModel]()
//        
//        if let productViewModelCDArr =  productDetailsCDEntity.productViewModelArr {
//            productViewModelCDArr.forEach { productDetailsCDModel in
//                var aProductData = ProductData(isDetailed: false, sampleCount: "", rxCount: "", rcpaCount: "", availableCount: "", totalCount: "", stockistName: "", stockistCode: "")
//        
//                if let aproductDetailsCDModel = productDetailsCDModel as? ProductDataCDModel {
//                    
//                    aProductData.product = aproductDetailsCDModel.product
//                    
//                    aProductData.availableCount = aproductDetailsCDModel.availableCount ?? ""
//                    aProductData.isDetailed = aproductDetailsCDModel.isDetailed
//                    aProductData.rcpaCount = aproductDetailsCDModel.rcpaCount ?? ""
//                    aProductData.rxCount = aproductDetailsCDModel.rxCount ?? ""
//                    aProductData.sampleCount = aproductDetailsCDModel.sampleCount ?? ""
//                    aProductData.stockistCode = aproductDetailsCDModel.stockistCode ?? ""
//                    aProductData.stockistName = aproductDetailsCDModel.stockistName ?? ""
//                    aProductData.totalCount = aproductDetailsCDModel.totalCount ?? ""
//                    
//                    let productViewModel = ProductViewModel(product: aProductData)
//                    productViewModelArr.append(productViewModel)
//                }
//            }
//        }
//        productSelectedListViewModel.productViewModel = productViewModelArr
//        vc.productSelectedListViewModel = productSelectedListViewModel
//    }
//    
//    
//    //Jointwork
//    if let jwEntityDescription  = NSEntityDescription.entity(forEntityName: "JointWorkViewModelCDEntity", in: context) {
//        let jwDetailsCDEntity = ftchedDCRcall?.jointWorkViewModel ?? JointWorkViewModelCDEntity(entity: jwEntityDescription, insertInto: context)
//        ///ProductSelectedListViewModel
//        
//        let jwSelectedListViewModel = JointWorksListViewModel()
//        
//        
//        
//        var jwViewModelArr =  [JointWorkViewModel]()
//        
//        if let jwViewModelCDArr =  jwDetailsCDEntity.jointWorkViewModelArr {
//            jwViewModelCDArr.forEach { jwDetailsCDModel in
//               
//        
//                if let ajwDetailsCDModel = jwDetailsCDModel as? JointWorkDataCDModel {
//                    
//                    if let jointWork = ajwDetailsCDModel.jointWork {
//                        var ajwData = JointWorkViewModel(jointWork: jointWork)
//                        jwViewModelArr.append(ajwData)
//                        jwSelectedListViewModel.addJointWorkViewModel(ajwData)
//                    }
//                 
//                }
//                
//            }
//          
//        }
//       // productSelectedListViewModel.productViewModel = productViewModelArr
//        vc.jointWorkSelectedListViewModel = jwSelectedListViewModel
//    }
//    
//    //RCPA
//    if let rcpaEntityDescription = NSEntityDescription.entity(forEntityName: "RCPAdetailsCDEntity", in: context) {
//        // dispatchGroup.enter()
//        let rcpaDetailsCDEntity = ftchedDCRcall?.rcpaDetailsModel ?? RCPAdetailsCDEntity(entity: rcpaEntityDescription, insertInto: context)
//        
//        
//        ///[RCPAdetailsModal]
//        var rcpaDetailsModelArr = [RCPAdetailsModal]()
//
//        if let rcpaDetailsCDModelArr = rcpaDetailsCDEntity.rcpadtailsCDModelArr  {
//            
//            rcpaDetailsCDModelArr.forEach { aRCPAdetailsCDModel in
//                
//                ///RCPAdetailsModal
//                let rcpaDetailsModel =  RCPAdetailsModal()
//                
//                if let aRCPAdetailsCDModel = aRCPAdetailsCDModel as? RCPAdetailsCDModel {
//                    let addedChemist = aRCPAdetailsCDModel.addedChemist
//                    rcpaDetailsModel.addedChemist = addedChemist
//                    
//                    ///ProductDetails
//                    var aproductDetails = ProductDetails()
//                    
//                    if let  productDetailsCDModel = aRCPAdetailsCDModel.addedProductDetails {
//                  
//                        
//                        aproductDetails.addedQuantity = productDetailsCDModel.addedQuantity
//                        aproductDetails.addedRate =   productDetailsCDModel.addedRate
//                        aproductDetails.addedTotal = productDetailsCDModel.addedTotal
//                        aproductDetails.addedValue =  productDetailsCDModel.addedValue
//                      
//                        ///[ProductWithCompetiors]
//                        var  addedProductsArr = [ProductWithCompetiors]()
//                        
//                        if let addedProductArr = productDetailsCDModel.addedProductArr {
//                            addedProductArr.forEach { addedProductWithCompetitor in
//                                
//                                ///ProductWithCompetiors
//                                var addedProduct = ProductWithCompetiors()
//                                
//                                if let addedProductWithCompetitor = addedProductWithCompetitor as? ProductWithCompetiorsCDModel {
//
//                                    addedProduct.addedProduct = addedProductWithCompetitor.addedProduct
//                                    
//                                    ///AdditionalCompetitorsInfo
//                                    var additionalCompetitorsInfoArr =  [AdditionalCompetitorsInfo]()
//                                    
//                                    if let competitorsInfoArr = addedProductWithCompetitor.competitorsInfoArr {
//                                        competitorsInfoArr.forEach { additionalCompetitorsInfoCDModel in
//                                            
//                                            if let additionalCompetitorsInfoCDModel = additionalCompetitorsInfoCDModel as? AdditionalCompetitorsInfoCDModel {
//                                                
//                                                ///AdditionalCompetitorsInfo
//                                                
//                                                var additionalCompetitorsInfo = AdditionalCompetitorsInfo()
//                                                
//                                                additionalCompetitorsInfo.competitor =  additionalCompetitorsInfoCDModel.competitor
//                                                additionalCompetitorsInfo.qty =  additionalCompetitorsInfoCDModel.qty
//                                                additionalCompetitorsInfo.rate = additionalCompetitorsInfoCDModel.rate
//                                                additionalCompetitorsInfo.remarks = additionalCompetitorsInfoCDModel.remarks
//                                                additionalCompetitorsInfo.value = additionalCompetitorsInfoCDModel.value
//                                                additionalCompetitorsInfoArr.append(additionalCompetitorsInfo)
//                                            }
//                                        }
//                                        addedProduct.competitorsInfo = additionalCompetitorsInfoArr
//                                    }
//                                   
//                                }
//                                addedProductsArr.append(addedProduct)
//                                
//                            }
//                            aproductDetails.addedProduct = addedProductsArr
//                        }
//                        
//                        rcpaDetailsModel.addedProductDetails = aproductDetails
//                    }
//                }
//                rcpaDetailsModelArr.append(rcpaDetailsModel)
//            }
//            
//        }
//         dump(rcpaDetailsModelArr)
//        vc.rcpaDetailsModel = rcpaDetailsModelArr
//     
//    }
//    self.navigationController?.pushViewController(vc, animated: true)
//}
