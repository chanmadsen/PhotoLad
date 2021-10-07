//
//  Gear.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//
//

import Foundation

class GearList: Codable {

    var item: String
    var quantity: String?
    var isToggled: Bool
    let uuid: String
    
    init(item: String, quantity: String?, isToggled: Bool = false, uuid: String = UUID().uuidString) {
        self.item = item
        self.quantity = quantity
        self.isToggled = isToggled
        self.uuid = uuid
    }
}// End of class

extension GearList: Equatable {
    static func == (lhs: GearList, rhs: GearList) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
}
