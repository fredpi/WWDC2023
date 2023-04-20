//
//  GlobalState.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import SwiftUI

class GlobalState: ObservableObject {
    // MARK: - Properties: Static
    public static let shared = GlobalState()
    
    // MARK: Instance
    @Published public private(set) var page = 0 {
        didSet {
            isPlaying = true
            showTutorial = page > tutorialShownUpTo
            tutorialShownUpTo = max(tutorialShownUpTo, page)
            numberOfTotalSatellites = PageSpec.configuration(forPage: page).orbits.reduce(0) { $0 + $1.numberOfSatellites }
        }
    }
    
    @Published public var showTutorial = false
    @Published public var showCredits = false
    @Published public var isPlaying = true
    @Published public var numberOfVisibleSatellites: Int = 0
    @Published public private(set) var numberOfTotalSatellites: Int = 0
    @Published public var pointOfInterest: PointOfInterest = .london
    public var showCityPicker: Bool { PageSpec.configuration(forPage: page).coloringMode == .accordingToVisibility }
    public var canShowCredits: Bool { tutorialShownUpTo == Constants.maxPage }
    public var canGoDown: Bool { page > Constants.minPage }
    public var canGoUp: Bool { page < Constants.maxPage }
    public var isChangingPage = false
    
    private var tutorialShownUpTo: Int = 0
    
    // MARK: - Initializers
    private init() {
        page = Constants.minPage
    }

    // MARK: - Methods
    public func goToNextPage() {
        guard !isChangingPage else { return }
        page = min(Constants.maxPage, page + 1)
    }

    public func goToPreviousPage() {
        guard !isChangingPage else { return }
        page = max(Constants.minPage, page - 1)
    }
}
