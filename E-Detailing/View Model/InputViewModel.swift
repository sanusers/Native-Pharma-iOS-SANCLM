//
//  InputViewModel.swift
//  E-Detailing
//
//  Created by SANEFORCE on 16/08/23.
//

import Foundation

class InputSelectedListViewModel {
    
    private var inputViewModel = [InputViewModel]()
    
    
    let input = [Input]()
    
    func fetchInputData(_ index : Int) -> Objects {
        let input = DBManager.shared.getInput()
        let value = self.inputData()
        
        let isSelected = value.filter{$0.code.contains(input[index].code ?? "")}
        return Objects(Object:input[index], isSelected: isSelected.isEmpty ? false : true)
    }
    
    func numberOfInputs () -> Int{
        return DBManager.shared.getInput().count
    }
    
    
    func addInputViewModel(_ vm : InputViewModel) {
        inputViewModel.append(vm)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return inputViewModel.count
    }
    
    func inputData() -> [InputViewModel] {
        return inputViewModel
    }
    
    func removeAtIndex(_ index : Int) {
        inputViewModel.remove(at: index)
    }
    
    func removebyId(_ id : String){
        inputViewModel.removeAll{$0.code == id}
    }
    
    func fetchDataAtIndex(_ index : Int) -> InputViewModel {
        return inputViewModel[index]
    }
    
    func setInputCodeAtIndex(_ index : Int , samQty : String) {
        inputViewModel[index].input.updateInputCount(samQty) //  = samQty
    }
    
    
}

class InputViewModel {
    
    var input : InputData
    
    init(input: InputData) {
        self.input = input
    }
    
    var name : String {
        return input.input.name ?? ""
    }
    
    var code : String {
        return input.input.code ?? ""
    }
    
    var inputCount : String {
        return input.inputCount
    }
}



struct InputData {
    var input : Input
    var inputCount : String
    
    mutating func updateInputCount(_ value : String) {
        inputCount = value
    }
}


 
struct Objects {
    var Object : AnyObject
    var isSelected : Bool
}
 
