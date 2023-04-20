//
//  Constants.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation

struct Constants {
    public static let minPage: Int = 1
    public static let maxPage: Int = 8
    public static let earthRadius: Double = 0.25
    public static let satelliteRadius: Double = 0.025
    public static let cameraAltitude: Double = 2.5
    public static let sunDistance: Double = 100
    public static let globeRotationPeriod: Double = 60.0
    public static let ambientLightIntensity: Double = 50.0
    public static let nearSatelliteHeight: Double = earthRadius * 5000 / 6371
    public static let gpsSatelliteHeight: Double = earthRadius * 20200 / 6371
    public static let geostationarySatelliteHeight: Double = earthRadius * 35800 / 6371
    public static let markerAltitude: Double = earthRadius * 1.001
    public static let markerRadius: Double = 0.0125
}
