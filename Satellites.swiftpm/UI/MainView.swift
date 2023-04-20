//
//  MainView.swift
//
//
//  Created by Frederick Pietschmann on 08.04.23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var state: GlobalState
    
    var body: some View {
        ZStack {
            PagingSwiftUI().blur(radius: state.showTutorial || state.showCredits ? 8 : 0)
            NavigationView().blur(radius: state.showTutorial || state.showCredits ? 8 : 0)
            if state.showTutorial { TutorialView() }
            if state.showCredits { CreditsView() }
        }.background { Color.black }
    }
}
