//
//  UserController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//

import CloudKit

class UserController {
    
    static let shared = UserController()
    
    func fetchAppleUserReference(completion: @escaping (Result<CKRecord.Reference?, UserError>) -> Void){
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let recordID = recordID else { return completion(.failure(.couldNotUnwrap)) }
            
            let reference = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
            completion(.success(reference))
            
        }
    }
    
}//End of class
