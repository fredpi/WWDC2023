//
//  OrbitNode.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation
import SceneKit

class OrbitNode: SCNNode {
    // MARK: - Properties
    let orbits: [Orbit]
    let coloringMode: Configuration.SatelliteColoringMode
    
    // MARK: - Initializers
    init(orbits: [Orbit], showOrbit: Bool, coloringMode: Configuration.SatelliteColoringMode) {
        self.orbits = showOrbit ? orbits : []
        self.coloringMode = coloringMode
        
        super.init()
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setup() {
        for (orbitIndex, orbit) in orbits.enumerated() {
            let torus = SCNTorus(ringRadius: Double(orbit.radius), pipeRadius: 0.002)
            torus.pipeSegmentCount = 60
            torus.ringSegmentCount = 60
            
            let color: UIColor
            if case .accordingToVisibility = coloringMode {
                color = .white
            } else {
                color = Orbit.colorForOrbit(atIndex: orbitIndex)
            }
            
            torus.firstMaterial!.diffuse.contents = color
            castsShadow = false

            let torusNode = SCNNode()
            torusNode.geometry = torus
            
            let rotationAxis = SCNVector3(x: 0, y: 1, z: 0).getCrossProductVector(with: orbit.normal)
            let angle = acos( orbit.normal.y / (sqrt(pow(orbit.normal.x, 2) + pow(orbit.normal.y, 2) + pow(orbit.normal.z, 2))) )
            let tilt: SCNMatrix4 = SCNMatrix4MakeRotation(angle, rotationAxis.x, rotationAxis.y, rotationAxis.z)
            torusNode.setWorldTransform(tilt)
            
            addChildNode(torusNode)
        }
    }
}
