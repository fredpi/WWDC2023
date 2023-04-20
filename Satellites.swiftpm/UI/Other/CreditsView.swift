//
//  CreditsView.swift
//
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import SwiftUI

struct CreditsView: View {
    @EnvironmentObject var state: GlobalState

    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.5)
                .onTapGesture { withAnimation { state.showCredits = false } } // Enables tap gesture over full view
                
            GeometryReader { metrics in
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 10) {
                            Text("👏 Credits").font(.system(size: 35)).foregroundColor(.black).padding(6)
                            Divider()
                            VStack {
                                Text("The **textures used to render our beautiful planet** are based on **NASA elevation and imagery data** processed and provided for free by [solarsystemscope.com](https://www.solarsystemscope.com/textures/).\n\n")
                                Text("I took some inspiration on **how to use these textures with _SceneKit_** from the [SwiftGlobe GitHub repository](https://github.com/dmojdehi/SwiftGlobe).")
                            }.font(.system(size: 20)).foregroundColor(.black).multilineTextAlignment(.center).padding(10)
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
