//
//  Gear.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//
//
import UIKit
import Foundation

struct Gear: Codable {
    var name: String
    var detail: String?
    var gearPhoto: UIImage?
    let uuid: String
    
    enum CodingKeys: String, CodingKey {
        case name, detail, uuid
        case gearPhoto = "photoData"
    }
    
    init(name: String, detail: String?, gearPhoto: UIImage?, uuid: String = UUID().uuidString) {
        self.name = name
        self.detail = detail
        self.gearPhoto = gearPhoto
        self.uuid = uuid
    
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(detail, forKey: .detail)
        try container.encode(photoData, forKey: .gearPhoto)
        try container.encode(uuid, forKey: .uuid)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.detail = try container.decode(String.self, forKey: .detail)
        let photoData = try container.decode(Data.self, forKey: .gearPhoto)
        self.gearPhoto = UIImage(data: photoData)
        self.uuid = try container.decode(String.self, forKey: .uuid)
    }
    
    var photoData: Data? {
        return gearPhoto?.jpegData(compressionQuality: 0.25)
    }
}

extension Gear: Equatable {
    static func == (lhs: Gear, rhs: Gear) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
