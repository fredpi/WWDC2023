//
//  GlobeNode.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation
import SceneKit

class GlobeNode: SCNNode {
    // MARK: - Initializers
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    public func startAnimation() {
        let spinRotation = SCNAction.rotate(by: 2 * .pi, around: SCNVector3(0, 1, 0), duration: Constants.globeRotationPeriod)
        let spinAction = SCNAction.repeatForever(spinRotation)
        runAction(spinAction)
    }
    
    public func stopAnimation() {
        removeAllActions()
    }
    
    private func setup() {
        // Setup globe
        let globeShape = SCNSphere(radius: Constants.earthRadius)
        globeShape.segmentCount = 40 // Increase resolution
        geometry = globeShape
        
        // Set material
        let earthMaterial = globeShape.firstMaterial!
        earthMaterial.diffuse.contents = "earth"
        earthMaterial.metalness.contents = "earth-metalness"
        earthMaterial.specular.contents = "earth-metalness"
        earthMaterial.specular.intensity = 0.2
        earthMaterial.normal.contents = "earth-bump"
        earthMaterial.normal.intensity = 5
        
        let emission = SCNMaterialProperty()
        emission.contents = "earth-nightmap"
        earthMaterial.setValue(emission, forKey: "emissionTexture")
        let shaderModifier = """
            uniform sampler2D emissionTexture;

            vec3 light = _lightingContribution.diffuse;
            float lum = max(0.0, 1 - 16.0 * (0.2126*light.r + 0.7152*light.g + 0.0722*light.b));
            vec4 emission = texture2D(emissionTexture, _surface.diffuseTexcoord) * lum * 0.5;
            _output.color += emission;
        """ // Required to make the earth shine
        earthMaterial.shaderModifiers = [.fragment: shaderModifier]
        earthMaterial.fresnelExponent = 2
    }
}
