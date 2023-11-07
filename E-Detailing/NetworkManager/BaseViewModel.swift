//
//  BaseViewModel.swift
//  E-Detailing
//
//  Created by San eforce on 07/11/23.
//

import Foundation

class BaseViewModel : NSObject{
    lazy var connectionHandler : ConnectionHandler? = {
        return ConnectionHandler()
    }()
    
    override init() {
        super.init()
    }
    

    
}
