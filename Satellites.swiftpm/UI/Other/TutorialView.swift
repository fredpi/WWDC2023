//
//  TutorialView.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var state: GlobalState

    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.5)
                .onTapGesture { withAnimation { state.showTutorial = false } } // Enables tap gesture over full view
                
            GeometryReader { metrics in
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 10) {
                            Text(PageSpec.title(for: state.page)).font(.system(size: 35)).foregroundColor(.black).padding(6)
                            Divider()
                            PageSpec.text(for: state.page)
                                .font(.system(size: 16)).foregroundColor(.black).multilineTextAlignment(.center).padding(10)
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .background { Color.white.opacity(0.5).background(.ultraThinMaterial) }
                        .cornerRadius(30)
                        .frame(width: max(metrics.size.width * 0.4, 500), alignment: .center)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}
