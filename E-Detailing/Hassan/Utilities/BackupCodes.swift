
//            print(type.getUrl)
//            print(type.getParams)
//
//            let date = Date().toString(format: "yyyy-MM-dd HH:mm:ss ZZZ")
//
//            print("date === \(date)")
//            AF.request(type.getUrl,method: .post,parameters: type.getParams).responseData(){ (response) in
//
//                let date1 = Date().toString(format: "yyyy-MM-dd HH:mm:ss ZZZ")
//
//                print("date1 === \(date1)")
//
//                switch response.result {
//
//                    case .success(_):
//                        do {
//                            let apiResponse = try JSONSerialization.jsonObject(with: response.data! ,options: JSONSerialization.ReadingOptions.allowFragments)
//
//                            let date1 = Date()
//                            print(date1)
//
//                            print("ssususnbjbo")
//                            print(apiResponse)
//                            print("ssusus")
//
//
//                            if let jsonObjectresponse = apiResponse as? [[String : Any]] {
//                                DBManager.shared.saveMasterData(type: type, Values: jsonObjectresponse,id: self.getSFCode)
//
//                                if type == MasterInfo.slides || type == MasterInfo.slideBrand {
//
//                                    self.loadedSlideInfo.append(type)
//                                    switch type {
//                                    case MasterInfo.slides:
//
//                                        var slides = AppDefaults.shared.getSlides()
//                                        slides.removeAll()
//                                        slides.append(contentsOf: jsonObjectresponse)
//                                       // AppDefaults.shared.save(key: .slide, value: slides)
//                                        LocalStorage.shared.setData(LocalStorage.LocalValue.slideResponse, data: response.data!)
//
//                                    //    self.toLoadPresentationData(type: MasterInfo.slides)
//
//
//                                    case MasterInfo.slideBrand:
//
//                                        LocalStorage.shared.setData(LocalStorage.LocalValue.BrandSlideResponse, data: response.data!)
//                                     //   self.toLoadPresentationData(type: MasterInfo.slideBrand)
//                                    default:
//                                        print("Yet to implement")
//                                    }
//
//                                    self.setLoader(pageType: .navigate)
//                                }
//                            }else if let responseDic = apiResponse as? [String : Any] {
//                                DBManager.shared.saveMasterData(type: type, Values: [responseDic],id: self.getSFCode)
//                            }
//                        }catch {
//                            print(error)
//                        }
//                    AppDefaults.shared.save(key: .syncTime, value: Date())
//                    let date = Date().toString(format: "dd MMM yyyy hh:mm a")
//                    self.lblSyncStatus.text = "Last Sync: " + date
//                    self.setLoader(pageType: .navigate, type: type)
//                    case .failure(let error):
//                    self.setLoader(pageType: .loaded)
//                        //ConfigVC().showToast(controller: self, message: "\(error)", seconds: 2)
//                    self.toCreateToast("\(error.localizedDescription)")
//                        print(error)
//                        return
//                }
//
//                if let index = self.masterData.firstIndex(of: type){
//                    self.animations[index] = false
//                    self.collectionView.reloadData()
//
//                 //   self.collectionView.reloadSections(NSIndexSet(index: index) as IndexSet) //, with: .automatic)
//                }
//
//
//                print("2")
//                print(response)
//                print("2")
