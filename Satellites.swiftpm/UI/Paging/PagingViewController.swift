//
//  PagingViewController.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import Combine
import UIKit
import SwiftUI

class PagingViewController: UIViewController {
    // MARK: - Properties
    private var currentPage: Int
    private var currentPageViewController: UIViewController
    private var pageSubscriberSink: AnyCancellable!
    
    // MARK: - Initializers
    public init() {
        currentPage = GlobalState.shared.page
        currentPageViewController = GlobeViewController(configuration: PageSpec.configuration(forPage: currentPage))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(currentPageViewController)
        view.addSubview(currentPageViewController.view)
        pageSubscriberSink = GlobalState.shared.$page.sink(receiveValue: pageDidChange)
    }

    private func pageDidChange(newPage: Int) {
        guard newPage != currentPage else { return }
        
        // Lock state changes
        GlobalState.shared.isChangingPage = true

        // Store new page
        let oldPage = currentPage
        currentPage = newPage
        let transitionDirection: Double = newPage > oldPage ? 1.0 : -1.0

        // Store new page view controller
        let oldViewController = currentPageViewController
        currentPageViewController = GlobeViewController(configuration: PageSpec.configuration(forPage: newPage))
        let newViewController = currentPageViewController
        
        // Add new view controller and its view
        addChild(newViewController)
        newViewController.view.center.x += view.bounds.width * transitionDirection
        view.addSubview(newViewController.view)

        // Animate transition
        UIView.animate(withDuration: 0.7, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
            oldViewController.view.alpha = 0
            oldViewController.view.center.x -= self.view.bounds.width * transitionDirection
            newViewController.view.center.x -= self.view.bounds.width * transitionDirection
        } completion: { _ in
            newViewController.view.frame = self.view.bounds
            oldViewController.willMove(toParent: nil)
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            GlobalState.shared.isChangingPage = false
        }
    }
}
