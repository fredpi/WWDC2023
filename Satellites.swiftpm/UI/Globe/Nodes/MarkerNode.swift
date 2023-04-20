//
//  MarkerNode.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import Foundation
import SceneKit

class MarkerNode: SCNNode {
    // MARK: - Initializers
    init(coordinate: Coordinate) {
        super.init()
        
        setup()
        move(to: coordinate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    public func move(to coordinate: Coordinate) {
        position = SCNVector3(
            x: -Float(Constants.markerAltitude * cos(coordinate.latitude * .pi / 180.0) * cos((coordinate.longitude + 90) * .pi / 180.0)),
            y: Float(Constants.markerAltitude * sin(coordinate.latitude * .pi / 180.0)),
            z: Float(Constants.markerAltitude * cos(coordinate.latitude * .pi / 180.0) * sin((coordinate.longitude + 90) * .pi / 180.0))
        )
        
        eulerAngles = SCNVector3(
            x: Float(-coordinate.latitude * .pi / 180.0) + .pi / 2,
            y: Float(coordinate.longitude * .pi / 180.0),
            z: 0
        )
    }
    
    private func setup() {
        geometry = SCNCylinder(radius: Constants.markerRadius, height: 0.001)
        geometry!.firstMaterial!.diffuse.contents = UIColor.yellow
        geometry!.firstMaterial!.emission.intensity = 0.2
        geometry!.firstMaterial!.emission.contents = UIColor.yellow
        geometry!.firstMaterial!.emission.intensity = 0.7
        castsShadow = false
        
        let animation = CABasicAnimation(keyPath: "scale")
        let fromValue: Float = 1
        let toValue: Float = 1.5
        animation.fromValue = SCNVector3(x: fromValue, y: fromValue, z: fromValue)
        animation.toValue = SCNVector3(x: toValue, y: toValue, z: toValue)
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        addAnimation(animation, forKey: "throb")
    }
}
