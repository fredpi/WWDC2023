//
//  App.swift
//
//
//  Created by Frederick Pietschmann on 08.04.23.
//

import Combine
import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
                .statusBar(hidden: true)
                .edgesIgnoringSafeArea(.all)
                .environmentObject(GlobalState.shared)
        }.commands { CommandGroup(replacing: .newItem, addition: { }) } // Disables multi-window
    }
}
