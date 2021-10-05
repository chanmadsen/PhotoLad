//
//  UserError.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//

import Foundation

enum UserError: LocalizedError {
    
    case ckError(Error)
    case couldNotUnwrap
    case unexpectedRecordsFound
    case noUserLoggedIn
    case noUserForPhotoLad
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Could not unwrap."
        case .unexpectedRecordsFound:
            return "Unexpected records found."
        case .noUserLoggedIn:
            return "No user logged in."
        case .noUserForPhotoLad:
            return "No user associated with the Hype."
        }
    }
}//end of enum
