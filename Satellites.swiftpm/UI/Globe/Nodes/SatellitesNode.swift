//
//  SatellitesNode.swift
//  
//
//  Created by Frederick Pietschmann on 15.04.23.
//

import Foundation
import SceneKit

class SatellitesNode: SCNNode {
    // MARK: - Properties
    private let orbits: [Orbit]
    private let coloringMode: Configuration.SatelliteColoringMode
    private let marker: MarkerNode
    private weak var globe: GlobeNode?
    
    private var satelliteNodes: [SCNNode] = []
    private var colors: [UIColor] = []
    
    private var startTimestamp: Double?
    private var phaseOffsets: [Double]
    
    private var displayLink: CADisplayLink?
    
    // MARK: - Initializers
    init(orbits: [Orbit], coloringMode: Configuration.SatelliteColoringMode, marker: MarkerNode, globe: GlobeNode) {
        self.orbits = orbits
        self.coloringMode = coloringMode
        self.marker = marker
        self.globe = globe
        self.phaseOffsets = (0 ..< orbits.count).map { _ in 0.0 }
        
        super.init()
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    public func startAnimation() {
        startTimestamp = CFAbsoluteTimeGetCurrent()
    }

    public func stopAnimation() {
        guard let startTimestamp else { return }
        phaseOffsets = orbits.enumerated().map { phaseOffsets[$0] + (CFAbsoluteTimeGetCurrent() - startTimestamp) / $1.period * 2 * .pi }
        self.startTimestamp = nil
    }
    
    public func invalidate() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    private func setup() {
        satelliteNodes = (0 ..< orbits.reduce(0) { $0 + $1.numberOfSatellites }).map { _ -> SCNNode in
            let node = SCNNode()
            let shape = SCNSphere(radius: Constants.satelliteRadius)
            node.geometry = shape
            return node
        }
        
        determineColors()
        
        satelliteNodes.forEach { addChildNode($0) }
        updateSatellites(forTime: CFAbsoluteTimeGetCurrent())
        
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkCalled))
        displayLink!.add(to: .current, forMode: .common)
        
        determineColorsLoop()
    }
    
    private func determineColors() {
        guard coloringMode == .accordingToVisibility else { return }
            
        var totalIndex: Int = 0
        var numberOfVisibleSatellites: Int = 0
        
        colors = orbits.enumerated().flatMap { orbitIndex, orbit in
            (0 ..< orbit.numberOfSatellites).map { satelliteIndex in
                let satelliteNode = satelliteNodes[totalIndex]
                totalIndex += 1
                
                guard let hitTest = globe?.hitTestWithSegment(from: marker.position, to: satelliteNode.convertPosition(satelliteNode.position, to: globe)) else {
                    return Orbit.colorForOrbit(atIndex: orbitIndex)
                }
                    
                let seesSatellite = !hitTest.contains { $0.node == globe }
                numberOfVisibleSatellites += seesSatellite ? 1 : 0
                return seesSatellite ? UIColor.green : UIColor.red
            }
        }
        
        DispatchQueue.main.async {
            guard !GlobalState.shared.isChangingPage else { return }
            GlobalState.shared.numberOfVisibleSatellites = numberOfVisibleSatellites
        }
    }
    
    private func determineColorsLoop() {
        guard displayLink != nil else { return }
        
        // Determine colors in a background loop to increase the performance
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now() + 0.01) { [weak self] in
            self?.determineColors()
            self?.determineColorsLoop()
        }
    }
    
    private func updateSatellites(forTime time: Double) {
        var totalIndex: Int = 0
        
        for (orbitIndex, orbit) in orbits.enumerated() {
            for satelliteIndex in 0 ..< orbit.numberOfSatellites {
                let satelliteNode = satelliteNodes[totalIndex]
                
                // Set position
                var phase = phaseOffsets[orbitIndex]
                phase += (startTimestamp.map { time - $0 } ?? 0) / orbit.period * 2 * .pi
                phase += Double(satelliteIndex) / Double(orbit.numberOfSatellites) * 2 * .pi
                satelliteNode.position = orbit.getPosition(for: Float(phase))
                
                let color: UIColor
                switch coloringMode {
                case .accordingToVisibility:
                    color = colors[totalIndex]
                    
                case .accordingToOrbit:
                    color = Orbit.colorForOrbit(atIndex: orbitIndex)
                }
                
                (satelliteNode.geometry as! SCNSphere).firstMaterial!.diffuse.contents = color
                
                totalIndex += 1
            }
        }
    }
    
    @objc
    private func displayLinkCalled() {
        updateSatellites(forTime: CFAbsoluteTimeGetCurrent())
    }
}
