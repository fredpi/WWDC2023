//
//  SunNode.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation
import SceneKit

class SunNode: SCNNode {
    // MARK: - Initializers
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setup() {
        position = SCNVector3(x: 0, y: 0, z: Float(Constants.sunDistance))
        light = SCNLight()
        light!.type = .omni
        light!.castsShadow = false
        light!.temperature = 5600
        light!.intensity = 1200
    }
}
