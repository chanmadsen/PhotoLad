//
//  LocationController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//

import UIKit
import CloudKit

class LocationsController {
    
    var privateDB = CKContainer.default().privateCloudDatabase
    
    static let shared = LocationsController()
    
    var locations: [Location] = []
    
    //MARK: - CRUD
    
    func createLocationWith(locationName: String, locationPhoto: UIImage, locationAddress: String, latitude: Double, longitude: Double, completion: @escaping (Result<Location, LocationError>) -> Void) {
        
        let newLocation = Location(locationName: locationName, locationAddress: locationAddress, latitude: latitude, longitude: longitude, locationPhoto: locationPhoto)
        
        let locationRecord = CKRecord(locations: newLocation)
        privateDB.save(locationRecord) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                  let savedLocation = Location(ckRecord: record) else { return completion(.failure(.couldNotUnwrap)) }
            
            print("saved success")
            self.locations.insert(savedLocation, at: 0)
            self.sortLocations()
            completion(.success(savedLocation))
        }
    }//End of create
    
    func fetchAllLocations(completion: @escaping (Result<[Location]?, LocationError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: LocationStrings.recordTypeKey , predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) {(records, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
            
            let locations = records.compactMap{Location(ckRecord: $0)}
            
            self.locations = locations
            
            self.sortLocations()
            
            print("number of fetched locations \(locations.count)")
            completion(.success(locations))
        }
    }//End of fetch
    
    func updateLocation(_ locations: Location, completion: @escaping(Result<Location?, LocationError>) -> Void) {
        
        let record = CKRecord(locations: locations)
        
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.modifyRecordsCompletionBlock = { (records, _, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let record = records?.first,
                  let updatedLocatioon = Location(ckRecord: record) else {
                return completion(.failure(.couldNotUnwrap))
            }
            self.sortLocations()
            completion(.success(updatedLocatioon))
        }
        privateDB.add(operation)
    }
    
    func deleteLocation(_ locations: Location, completion: @escaping (Result<Bool, LocationError>) -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [locations.recordID])
        
        operation.qualityOfService = .userInteractive
        operation.modifyRecordsCompletionBlock = {( records, _, error ) in
            if let error = error{
                return completion(.failure(.ckError(error)))
            }
            
            if records?.count == 0 {
                completion(.success(true))
            } else {
                return completion(.failure(.unexpectedRecordsFound))
            }
        }
        privateDB.add(operation)
    }
    
    
    func sortLocations(){
        self.locations.sort(by: { $0.locationName < $1.locationName })
    }
    
}//End of class
