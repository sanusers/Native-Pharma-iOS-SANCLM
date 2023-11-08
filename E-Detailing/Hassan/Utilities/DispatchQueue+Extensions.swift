//
//  DispatchQueue+Extensions.swift
//  E-Detailing
//
//  Created by Hassan on 08/11/23.
//

import Foundation

typealias Dispatch = DispatchQueue

extension Dispatch {

    static func background(_ task: @escaping () -> ()) {
        Dispatch.global(qos: .background).async {
            task()
        }
    }

    static func main(_ task: @escaping () -> ()) {
        Dispatch.main.async {
            task()
        }
    }
}
