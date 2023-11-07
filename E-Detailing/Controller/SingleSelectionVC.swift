//
//  SingleSelectionVC.swift
//  E-Detailing
//
//  Created by SANEFORCE on 27/06/23.
//

import UIKit

typealias SelectionCallBack = (_ selectedIndex : Int) -> Void



class SingleSelectionVC : UIViewController {
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchTitle : String!
    var selectionData = [AnyObject]()
    var originalData = [AnyObject]()
    
    
    var selectionList = [SelectionList]()
    var originalList = [SelectionList]()
    
    var isFromStruct : Bool!
  
    var completion : SelectionCallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblName.text = self.searchTitle
        self.originalData = self.selectionData
        
        self.originalList = self.selectionList
        

    }
    
    
    func didSelectCompletion(callback : @escaping SelectionCallBack) {
        self.completion = callback
    }
    
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

extension SingleSelectionVC : tableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isFromStruct == true {
            return self.selectionList.count
        }
        
        return self.selectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleSelectionCell", for: indexPath) as! SingleSelectionCell
        
     //   cell.lblName.text = self.selectionData[indexPath.row].name
        
        if self.isFromStruct == true {
            cell.lblName.text = self.selectionList[indexPath.row].name
        }else {
            cell.lblName.text = self.selectionData[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if self.isFromStruct == true {
            let lists = self.selectionList[indexPath.row]
            
            if let index = self.originalList.firstIndex(where: { (list) -> Bool in
                
                return list.code == lists.code
            }){
                if let completion = self.completion {
                    completion(index)
                }  
            }
            self.dismiss(animated: true)
            return 
        }
        
        
        let lists = self.selectionData[indexPath.row]
        
        if let index = self.originalData.firstIndex(where: { (list) -> Bool in
            
            print(self.originalData)
            return list.code ?? "" == lists.code ?? ""
        }){
            if let completion = self.completion {
                completion(index)
            }
        }
        self.dismiss(animated: true)
    }
}

class SingleSelectionCell : UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

 
//struct SelectionData {
//    var name : String!
//    var id : String!
//}
