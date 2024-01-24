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
        let placeName = placeNames[indexPath.row]

        let data = placeName.data(using: .utf8)
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
        private(set) var placeNames = [
            "Yosemite",
            "Yellowstone",
            "Theodore Roosevelt",
            "Sequoia",
            "Pinnacles",
            "Mount Rainier",
            "Mammoth Cave",
            "Great Basin",
            "Grand Canyon"
        ]
        
        /// The traditional method for rearranging rows in a table view.
     func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
            guard sourceIndex != destinationIndex else { return }
            
            let place = placeNames[sourceIndex]
            placeNames.remove(at: sourceIndex)
            placeNames.insert(place, at: destinationIndex)
        }
        
        /// The method for adding a new item to the table view's data model.
    func addItem(_ place: String, at index: Int) {
            placeNames.insert(place, at: index)
        }
    
}
