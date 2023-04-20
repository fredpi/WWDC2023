//
//  GlobeViewController.swift
//
//
//  Created by Frederick Pietschmann on 08.04.23.
//

import Foundation
import UIKit
import SceneKit

class GlobeViewController: UIViewController {
    // MARK: - Properties
    private let globeScene: GlobeScene
    private var sceneView: SCNView!
    
    // MARK: - Initializers
    init(configuration: Configuration) {
        globeScene = GlobeScene(configuration: configuration)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unavailable!")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            globeScene.invalidate()
        }
    }
    
    private func setupView() {
        // Only setup once
        guard view.subviews.isEmpty else { return }

        globeScene.view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addSubview(globeScene.view)

        // Define fixed constraints
        let constraints = [
            globeScene.view.topAnchor.constraint(equalTo: view.topAnchor),
            globeScene.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            globeScene.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            globeScene.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
