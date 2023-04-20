//
//  Orbit.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation
import SceneKit

struct Orbit {
    // MARK: - Properties
    public let numberOfSatellites: Int
    public let normal: SCNVector3
    public let radius: Float
    public let period: Double
    
    private let satellitePhaseOffsetRad: Float
    
    private var vector1: SCNVector3!
    private var vector2: SCNVector3!
    
    private static let orbitColors: [UIColor] = [
        .red,
        .green,
        .cyan,
        .orange,
        .blue,
        .magenta,
        .yellow
    ]
    
    // MARK: - Initializers
    init(normal: SCNVector3, heightAboveEarth: Double, satellitePhaseOffsetDeg: Float = 0, numberOfSatellites: Int = 1) {
        self.normal = normal
        self.numberOfSatellites = numberOfSatellites
        self.radius = Float(Constants.earthRadius + heightAboveEarth)
        self.satellitePhaseOffsetRad = satellitePhaseOffsetDeg * .pi / 180
        self.period = sqrt(pow(Double(radius) / (Constants.geostationarySatelliteHeight + Constants.earthRadius), 3)) * Constants.globeRotationPeriod
        
        vector1 = getOrthogonalVector(to: normal, withLength: radius)
        vector2 = vector1.getCrossProductVector(with: normal, length: radius)
    }
    
    // MARK: - Methods
    public static func colorForOrbit(atIndex index: Int) -> UIColor {
        orbitColors[index % orbitColors.count]
    }
    
    public func getPosition(for angle: Float) -> SCNVector3 {
        let angle = angle + satellitePhaseOffsetRad
        let cosine = -cos(angle)
        let sine = sin(angle)
        return SCNVector3(
            x: cosine * vector1.x + sine * vector2.x,
            y: cosine * vector1.y + sine * vector2.y,
            z: cosine * vector1.z + sine * vector2.z
        )
    }
    
    private func getOrthogonalVector(to normal: SCNVector3, withLength length: Float) -> SCNVector3 {
        var vector: SCNVector3
        if abs(normal.x) < 1e-6 {
            vector = SCNVector3(x: length, y: 0, z: 0)
        } else if abs(normal.y) < 1e-6 {
            vector = SCNVector3(x: 0, y: length, z: 0)
        } else if abs(normal.z) < 1e-6 {
            vector = SCNVector3(x: 0, y: 0, z: length)
        } else {
            // All three components exist
            vector = SCNVector3(x: 0, y: 1, z: -normal.y / normal.z)
            let currentLength = sqrt(1 + pow(vector.z, 2))
            vector.y = vector.y * length / currentLength
            vector.z = vector.z * length / currentLength
        }
        
        return vector
    }
}
