//
//  Extensions.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation
import SceneKit

extension SCNVector3 {
    func getCrossProductVector(with b: SCNVector3, length: Float? = nil) -> SCNVector3 {
        let a = self
        
        var vector: SCNVector3 = .init(
            a.y * b.z - a.z * b.y,
            a.z * b.x - a.x * b.z,
            a.x * b.y - a.y * b.x
        )
        
        if let length {
            let currentLength = sqrt(pow(vector.x, 2) + pow(vector.y, 2) + pow(vector.z, 2))
            
            vector.x = vector.x * length / currentLength
            vector.y = vector.y * length / currentLength
            vector.z = vector.z * length / currentLength
        }
        
        return vector
    }
}
