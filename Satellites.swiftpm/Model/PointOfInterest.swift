//
//  PointOfInterest.swift
//
//  PointOfInterest.swift
//
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import Foundation

enum PointOfInterest: Int, Identifiable, CaseIterable {
    case london
    case cupertino
    case sydney
    case nairobi
    case newYork
    case buenosAires

    var id: String { "\(rawValue)" }

    var asString: String {
        switch self {
        case .london:
            return "London"
            
        case .cupertino:
            return "Cupertino"
            
        case .sydney:
            return "Sydney"
            
        case .nairobi:
            return "Nairobi"
            
        case .newYork:
            return "New York"
            
        case .buenosAires:
            return "Buenos Aires"
        }
    }
    
    var coordinate: Coordinate {
        switch self {
        case .london:
            return Coordinate(latitude: 51.50335, longitude: -0.07940)
            
        case .cupertino:
            return Coordinate(latitude: 37.31931, longitude: -122.02834)
            
        case .sydney:
            return Coordinate(latitude: -33.87271, longitude: 151.20569)
            
        case .nairobi:
            return Coordinate(latitude: -1.28303, longitude: 36.81723)
            
        case .newYork:
            return Coordinate(latitude: 40.71298, longitude: -74.00720)
            
        case .buenosAires:
            return Coordinate(latitude: -34.61152, longitude: -58.42103)
        }
    }
}
