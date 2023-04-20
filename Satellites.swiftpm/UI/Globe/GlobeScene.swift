//
//  GlobeScene.swift
//
//
//  Created by Frederick Pietschmann on 08.04.23.
//

import ARKit
import Combine
import Foundation
import SceneKit

class GlobeScene {
    // MARK: - Properties
    public let view: SCNView
    
    private let configuration: Configuration
    
    private var lastFieldOfViewBeforeZoom: CGFloat?
    
    private var isCurrentlyPlaying: Bool = true
    private var isPlayingSubscriberSink: AnyCancellable!
    private var pointOfInterestSink: AnyCancellable!
    private var tutorialViewShownSink: AnyCancellable!
    private var tutorialViewShownNumberOfCalls: Int = 0
    
    // MARK: SceneKit
    private let scene = SCNScene()
    private let camera = SCNCamera()
    
    private let cameraNode = SCNNode()
    private let wrapperNode = SCNNode()
    
    private let globe = GlobeNode()
    private let sun = SunNode()
    private let satellites: SatellitesNode
    private let orbits: OrbitNode
    private let marker: MarkerNode = MarkerNode(coordinate: .init(latitude: 0, longitude: 0))
    
    // MARK: - Initializers
    init(configuration: Configuration) {
        self.configuration = configuration
        satellites = SatellitesNode(orbits: configuration.orbits, coloringMode: configuration.coloringMode, marker: marker, globe: globe)
        orbits = OrbitNode(orbits: configuration.orbits, showOrbit: configuration.showOrbit, coloringMode: configuration.coloringMode)
        view = configuration.isAR ? ARSCNView(frame: .zero, options: [:]) : SCNView(frame: .zero, options: [:])
        setup()
        startAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    public func invalidate() {
        satellites.invalidate()

        isPlayingSubscriberSink.cancel()
        pointOfInterestSink.cancel()
        tutorialViewShownSink.cancel()
        
        (view as? ARSCNView)?.session.pause()
    }
    
    private func setup() {
        // Setup nodes
        scene.rootNode.addChildNode(wrapperNode)
        wrapperNode.addChildNode(sun)
        wrapperNode.addChildNode(globe)
        wrapperNode.addChildNode(orbits)
        wrapperNode.addChildNode(satellites)
        
        if configuration.coloringMode == .accordingToVisibility {
            marker.move(to: GlobalState.shared.pointOfInterest.coordinate)
            globe.addChildNode(marker)
        }
        
        // Settings
        view.scene = scene
        view.autoenablesDefaultLighting = false
        view.showsStatistics = false
        
        // Subscribers
        isPlayingSubscriberSink = GlobalState.shared.$isPlaying.sink(receiveValue: isPlayingDidChange)
        pointOfInterestSink = GlobalState.shared.$pointOfInterest.sink(receiveValue: pointOfInterestDidChange)
        tutorialViewShownSink = GlobalState.shared.$showTutorial.sink(receiveValue: tutorialViewShownDidChange)
        
        // Final setup for default display or AR
        if configuration.isAR && ARWorldTrackingConfiguration.isSupported {
            scene.background.contents = "background" // Show background until startARIfApplicable() is called
        } else {
            // Add static background
            scene.background.contents = "background"
            
            // Initial rotate & tilt
            apply(rotate: -.pi/8, tilt: -.pi/16)
            
            // Gesture recognizers
            let pan = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture))
            pan.maximumNumberOfTouches = 1
            view.addGestureRecognizer(pan)
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(onPinchGesture))
            view.addGestureRecognizer(pinch)
            
            // Add camera
            camera.fieldOfView = configuration.fieldOfView.initial
            camera.zFar = 10000
            cameraNode.position = SCNVector3(x: 0, y: 0, z: Float(Constants.earthRadius + Constants.cameraAltitude))
            cameraNode.constraints = [SCNLookAtConstraint(target: globe)]
            let ambientLight = SCNLight()
            ambientLight.type = .ambient
            ambientLight.intensity = Constants.ambientLightIntensity
            cameraNode.light = ambientLight
            cameraNode.camera = camera
            scene.rootNode.addChildNode(cameraNode)
        }
    }
    
    private func startAnimation() {
        globe.startAnimation()
        satellites.startAnimation()
    }
    
    private func stopAnimation() {
        globe.stopAnimation()
        satellites.stopAnimation()
    }
    
    private func startARIfApplicable() {
        guard configuration.isAR && ARWorldTrackingConfiguration.isSupported else { return }
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        (view as? ARSCNView)?.session.run(config)
        
        scene.background.contents = nil
    }
    
    private func apply(rotate: Double, tilt: Double) {
        let currentPivot = wrapperNode.pivot
        let changePivot = SCNMatrix4Invert(SCNMatrix4Mult(SCNMatrix4Rotate(wrapperNode.transform, -Float(rotate), 0.0, 1.0, 0.0), SCNMatrix4Rotate(wrapperNode.worldTransform, -Float(tilt), 1.0, 0.0, 0.0)))
        wrapperNode.pivot = SCNMatrix4Mult(changePivot, currentPivot)
    }
    
    // MARK: Observers
    private func isPlayingDidChange(isPlaying: Bool) {
        if !GlobalState.shared.isChangingPage {
            if isPlaying && !isCurrentlyPlaying {
                startAnimation()
            } else if !isPlaying && isCurrentlyPlaying {
                stopAnimation()
            }
            
            isCurrentlyPlaying = isPlaying
        }
    }
    
    private func pointOfInterestDidChange(pointOfInterest: PointOfInterest) {
        if !GlobalState.shared.isChangingPage {
            marker.move(to: pointOfInterest.coordinate)
        }
    }
    
    private func tutorialViewShownDidChange(tutorialViewShown: Bool) {
        tutorialViewShownNumberOfCalls += 1 // This is a bit hacky...
        if !tutorialViewShown, tutorialViewShownNumberOfCalls > 1, (view as? ARSCNView)?.session.configuration == nil {
            startARIfApplicable()
        }
    }
    
    @objc
    private func onPanGesture(pan: UIPanGestureRecognizer) {
        guard let sceneView = pan.view else { return }
        
        let translation = pan.translation(in: sceneView)

        var angle = sqrt(pow(translation.x, 2) + pow(translation.y, 2)) * .pi / 180.0 / min(sceneView.frame.height, sceneView.frame.width)
        angle = angle * 20 * sqrt(camera.fieldOfView) // scale according to field of view
        
        let rotationVector = SCNVector4(x: Float(translation.y), y: Float(translation.x), z: 0, w: Float(angle))
        
        wrapperNode.rotation = rotationVector

        if pan.state == .ended {
            let currentPivot = wrapperNode.pivot
            let changePivot = SCNMatrix4Invert(wrapperNode.transform)

            wrapperNode.pivot = SCNMatrix4Mult(changePivot, currentPivot)
            wrapperNode.rotation = SCNVector4Zero
        }
    }
    
    @objc
    private func onPinchGesture(pinch: UIPinchGestureRecognizer){
        if pinch.state == .began {
            lastFieldOfViewBeforeZoom = camera.fieldOfView
        } else if let lastFov = lastFieldOfViewBeforeZoom {
            camera.fieldOfView = min(
                configuration.fieldOfView.maximum,
                max(
                    configuration.fieldOfView.minimum,
                    lastFov / CGFloat(pinch.scale)
                )
            )
        }
    }
}
