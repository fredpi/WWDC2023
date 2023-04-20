//
//  NavigationView.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import SwiftUI

struct NavigationView: View {
    @EnvironmentObject var state: GlobalState

    var body: some View {
        ZStack {
            // Regular navigation items (left-aligned)
            HStack {
                Spacer().frame(width: 12)
                VStack {
                    Spacer().frame(height: 12)
                    
                    HStack {
                        NavigationButtonView(buttonName: "arrow.backward.circle.fill", enabled: state.canGoDown) { withAnimation { state.goToPreviousPage() } }
                        Spacer().frame(width: 12)
                        
                        ZStack(alignment: .leading) {
                            Color.white.opacity(0.5).background(.ultraThinMaterial)
                            HStack {
                                Spacer().frame(width: 30)
                                Text("\(state.page)/\(Constants.maxPage)").foregroundColor(.black).font(.system(size: 16, weight: .light, design: .monospaced)).tint(.black)
                                Text(PageSpec.title(for: state.page)).font(.system(size: 20)).fontWeight(.medium).tint(.black)
                                Spacer().frame(width: 30)
                            }
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(height: 60, alignment: .center)
                        .cornerRadius(30)
                        .onTapGesture { withAnimation { state.showTutorial = true } }
                        
                        Spacer().frame(width: 12)
                        NavigationButtonView(buttonName: "arrow.forward.circle.fill", enabled: state.canGoUp) { withAnimation { state.goToNextPage() } }
                        Spacer().frame(width: 12)
                        NavigationButtonView(buttonName: "info.circle.fill", enabled: true) { withAnimation { state.showTutorial = true } }
                        Spacer().frame(width: 12)
                        NavigationButtonView(buttonName: state.isPlaying ? "pause.circle.fill" : "play.circle.fill", enabled: true) {
                            state.isPlaying = !state.isPlaying
                        }
                        
                        if state.showCityPicker {
                            Spacer().frame(width: 12)
                            Menu {
                                Picker(selection: $state.pointOfInterest) {
                                    ForEach(PointOfInterest.allCases) { function in
                                        Text(function.asString).tag(function)
                                    }
                                } label: {}
                            } label: {
                                ZStack(alignment: .leading) {
                                    Color.white.opacity(0.5).background(.ultraThinMaterial)
                                    HStack {
                                        Spacer().frame(width: 30)
                                        VStack {
                                            Spacer()
                                            Text(state.pointOfInterest.asString).font(.system(size: 20)).fontWeight(.medium).tint(.black)
                                            Text("Visible Satellites: \(state.numberOfVisibleSatellites) / \(state.numberOfTotalSatellites)").font(.system(size: 16)).fontWeight(.light).tint(.black)
                                            Spacer()
                                        }
                                        Spacer().frame(width: 30)
                                    }
                                }
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(height: 60, alignment: .center)
                                .cornerRadius(30)
                            }
                        }
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            
            // Credit button (right-aligned)
            if state.canShowCredits {
                HStack {
                    Spacer()
                    VStack {
                        Spacer().frame(height: 12)
                        NavigationButtonView(buttonName: "pin.circle.fill", enabled: true) { withAnimation { state.showCredits = true } }
                        Spacer()
                    }
                    Spacer().frame(width: 12)
                }
            }
        }
    }
}
