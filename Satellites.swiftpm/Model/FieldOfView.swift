//
//  FieldOfView.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import Foundation

struct FieldOfView {
    // MARK: - Properties: Static
    static let `default`: FieldOfView = .init(
        initial: 50,
        minimum: 20,
        maximum: 80
    )
    
    static let closeUp: FieldOfView = .init(
        initial: 20,
        minimum: 10,
        maximum: 30
    )
    
    static let farAway: FieldOfView = .init(
        initial: 80,
        minimum: 20,
        maximum: 100
    )
    
    // MARK: Instance
    var initial: Double
    var minimum: Double
    var maximum: Double
}
