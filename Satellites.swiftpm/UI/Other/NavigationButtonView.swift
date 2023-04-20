//
//  NavigationButtonView.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import Foundation
import SwiftUI

struct NavigationButtonView: View {
    let buttonName: String
    let enabled: Bool
    let handler: () -> Void

    init(buttonName: String, enabled: Bool, handler: @escaping () -> Void) {
        self.buttonName = buttonName
        self.enabled = enabled
        self.handler = handler
    }

    var body: some View {
        ZStack {
            Color.white.opacity(0.5).background(.ultraThinMaterial)
            Image(systemName: buttonName).resizable().renderingMode(.template)
                .foregroundColor(enabled ? .black : .black.opacity(0.5))
                .frame(width: 30, height: 30)
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 60, height: 60, alignment: .center)
        .cornerRadius(30)
        .onTapGesture {
            if enabled {
                handler()
            }
        }
    }
}
