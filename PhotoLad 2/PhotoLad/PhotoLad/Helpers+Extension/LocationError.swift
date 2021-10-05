//
//  LocationError.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//

import Foundation

enum LocationError: LocalizedError {
    
    case ckError(Error)
    case couldNotUnwrap
    case unexpectedRecordsFound
    case noUserLoggedIn
    
    var errorDescription: String? {
        switch self {
        
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Unable to retreive this location."
        case .unexpectedRecordsFound:
            return "Looks like we tried to delete the records, but had an issue."
        case .noUserLoggedIn:
            return "No user logged in."
        }
    }
}
