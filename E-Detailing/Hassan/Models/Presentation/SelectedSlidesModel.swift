//
//  SelectedSlidesModel.swift
//  E-Detailing
//
//  Created by San eforce on 24/01/24.
//

import Foundation
import UIKit
import MobileCoreServices

extension SelectedSlidesModel {
    /**
         A helper function that serves as an interface to the data model,
         called by the implementation of the `tableView(_ canHandle:)` method.
    */
    func canHandle(_ session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    /**
         A helper function that serves as an interface to the data mode, called
         by the `tableView(_:itemsForBeginning:at:)` method.
    */
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let slideNames = slideNames[indexPath.row]

        var data = Data()
        
        // Use JSONEncoder to convert the class object to Data
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Optional: Add formatting for readability
            let jsonData = try encoder.encode(slideNames)
            
            // Now you have the class object as Data
            print(String(data: jsonData, encoding: .utf8) ?? "Failed to convert Data to String")
            data = jsonData
        } catch {
            print("Error encoding class object to Data: \(error)")
        }
        
        let itemProvider = NSItemProvider()
        
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            return nil
        }

        return [
            UIDragItem(itemProvider: itemProvider)
        ]
    }
}

class SelectedSlidesModel {
    
    
    var slideNames : [SlidesModel] = []
        
        /// The traditional method for rearranging rows in a table view.
     func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
            guard sourceIndex != destinationIndex else { return }
            
         let place = slideNames[sourceIndex]
         slideNames.remove(at: sourceIndex)
         slideNames.insert(place, at: destinationIndex)
        }
        
        /// The method for adding a new item to the table view's data model.
    func addItem(_ place: SlidesModel, at index: Int) {
        slideNames.insert(place, at: index)
        }
    
}
