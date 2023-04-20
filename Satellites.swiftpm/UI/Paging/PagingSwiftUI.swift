//
//  PagingSwiftUI.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import Foundation
import SwiftUI

struct PagingSwiftUI: UIViewControllerRepresentable {
    typealias UIViewControllerType = PagingViewController
    func makeUIViewController(context: Context) -> UIViewControllerType { UIViewControllerType() }
    func updateUIViewController(_ vc: UIViewControllerType, context: Context) { }
}
