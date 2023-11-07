//
//  JointWorkViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 17/08/23.
//

import Foundation


class JointWorksListViewModel {
    
    private var jointWorksListViewModel = [JointWorkViewModel] ()
    
    func addJointWorkViewModel(_ vm : JointWorkViewModel) {
        jointWorksListViewModel.append(vm)
    }
    
    func getJointWorkData() -> [JointWorkViewModel] {
        return jointWorksListViewModel
    }
    
    func numberofSelectedRows() -> Int  {
        return jointWorksListViewModel.count
    }
    
    func removeAtindex(_ index :Int) {
        jointWorksListViewModel.remove(at: index)
    }
    
    func fetchDataAtIndex(_ index :Int) -> JointWorkViewModel {
        return jointWorksListViewModel[index]
    }
    
    func removeById(id : String) {
        jointWorksListViewModel.removeAll{$0.code == id}
    }
    
    
    func numberOfRows(_ section: Int) -> Int {
        return jointWorksListViewModel.count
    }
    
    func fetchJointWorkData(_ index : Int) -> Objects {
        
        let jointWorks = DBManager.shared.getJointWork()
        
        let value = self.getJointWorkData()
        let isSelected = value.filter{$0.code.contains(jointWorks[index].code ?? "")}
        
        return Objects(Object: jointWorks[index], isSelected: isSelected.isEmpty ? false : true, priority: "")
    }
    
    func numbersOfJointWorks() -> Int {
        return DBManager.shared.getJointWork().count
    }
    
}

class JointWorkViewModel {
    
    let jointWork : JointWork
    
    init(jointWork: JointWork) {
        self.jointWork = jointWork
    }
    
    var name : String {
        return jointWork.name ?? ""
    }
    
    var code : String {
        return jointWork.code ?? ""
    }
}
