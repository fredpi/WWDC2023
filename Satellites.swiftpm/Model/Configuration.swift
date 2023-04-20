//
//  Configuration.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation
import SceneKit

struct Configuration {
    // MARK: - Subtypes
    enum SatelliteColoringMode {
        case accordingToVisibility
        case accordingToOrbit
    }
    
    // MARK: - Properties
    var orbits: [Orbit]
    var fieldOfView: FieldOfView
    var coloringMode: SatelliteColoringMode
    var showOrbit: Bool
    var isAR: Bool
}
