//
//  Locations.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//

import UIKit
import CloudKit
import Foundation

struct LocationStrings {
    static let recordTypeKey = "PhotoLad"
    fileprivate static let locationNameKey = "locationName"
    fileprivate static let locationAddressKey = "locationAddress"
    fileprivate static let longitude = "longitude"
    fileprivate static let latitude = "latitude"
    fileprivate static let userReferenceKey = "userReference"
    fileprivate static let photoKey = "photo"
}//end of struct

class Location {
    var photoData: Data?
    var locationName: String
    var locationAddress: String
    var longitude: Double
    var latitude: Double
    var recordID: CKRecord.ID
    var userReference: CKRecord.Reference?
    var locationPhoto: UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var photoAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            
            do{
                try photoData?.write(to: fileURL)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init (locationName: String, locationAddress: String, latitude: Double, longitude: Double, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), locationPhoto: UIImage? = nil) {
        self.locationName = locationName
        self.locationAddress = locationAddress
        self.latitude = latitude
        self.longitude = longitude
        self.recordID = recordID
        self.locationPhoto = locationPhoto
    }
}//End of class

extension Location: Equatable {
    
    convenience init?(ckRecord: CKRecord) {
        guard let locationName = ckRecord[LocationStrings.locationNameKey] as? String,
              let locationAddress = ckRecord[LocationStrings.locationAddressKey] as? String,
              let latitude = ckRecord[LocationStrings.latitude] as? Double,
              let longitude = ckRecord[LocationStrings.longitude] as? Double
        else { return nil }
        
        
        var locationPhoto: UIImage?
        
        if let photoAsset = ckRecord[LocationStrings.photoKey] as? CKAsset {
            do{
                let data = try Data(contentsOf: photoAsset.fileURL!)
                locationPhoto = UIImage(data: data)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        
        self.init(locationName: locationName, locationAddress: locationAddress,latitude: latitude, longitude: longitude, recordID: ckRecord.recordID, locationPhoto: locationPhoto)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return rhs.recordID == lhs.recordID
    }
}

extension CKRecord {
    
    convenience init (locations: Location) {
        self.init(recordType: LocationStrings.recordTypeKey, recordID: locations.recordID)
        
        self.setValuesForKeys([
            LocationStrings.locationNameKey : locations.locationName,
            LocationStrings.locationAddressKey : locations.locationAddress,
            LocationStrings.latitude : locations.latitude,
            LocationStrings.longitude : locations.longitude
        ])
        
        if let reference = locations.userReference {
            self.setValue(reference, forKey: LocationStrings.userReferenceKey)
        }
        if let locationPhoto = locations.photoAsset {
            self.setValue(locationPhoto, forKey: LocationStrings.photoKey)
        }
    }
}

