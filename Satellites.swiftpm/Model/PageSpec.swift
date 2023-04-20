//
//  PageSpec.swift
//  
//
//  Created by Frederick Pietschmann on 16.04.23.
//

import ARKit
import SceneKit
import SwiftUI

struct PageSpec {
    static func configuration(forPage page: Int) -> Configuration {
        switch page {
        case 1:
            return Configuration(
                orbits: [],
                fieldOfView: .closeUp,
                coloringMode: .accordingToOrbit,
                showOrbit: true,
                isAR: false
            )
            
        case 2:
            return Configuration(
                orbits: [
                    Orbit(normal: SCNVector3(1, 0, 0), heightAboveEarth: Constants.gpsSatelliteHeight, numberOfSatellites: 1)
                ],
                fieldOfView: .default,
                coloringMode: .accordingToOrbit,
                showOrbit: true,
                isAR: false
            )
            
        case 3:
            return Configuration(
                orbits: [
                    Orbit(normal: SCNVector3(1, 0, 0), heightAboveEarth: Constants.gpsSatelliteHeight, numberOfSatellites: 6)
                ],
                fieldOfView: .default,
                coloringMode: .accordingToVisibility,
                showOrbit: true,
                isAR: false
            )
            
        case 4:
            return Configuration(
                orbits: [
                    Orbit(normal: SCNVector3(0, 0, 1), heightAboveEarth: Constants.nearSatelliteHeight, numberOfSatellites: 6),
                    Orbit(normal: SCNVector3(1, 0, 0), heightAboveEarth: Constants.gpsSatelliteHeight, numberOfSatellites: 6),
                    Orbit(normal: SCNVector3(0, 1, 0), heightAboveEarth: Constants.geostationarySatelliteHeight, numberOfSatellites: 6)
                ],
                fieldOfView: .farAway,
                coloringMode: .accordingToVisibility,
                showOrbit: true,
                isAR: false
            )
            
        case 5:
            return Configuration(
                orbits: [
                    Orbit(normal: SCNVector3(0, 0, 1), heightAboveEarth: Constants.nearSatelliteHeight, numberOfSatellites: 6),
                    Orbit(normal: SCNVector3(1, 0, 0), heightAboveEarth: Constants.gpsSatelliteHeight, numberOfSatellites: 6),
                    Orbit(normal: SCNVector3(0, 1, 0), heightAboveEarth: Constants.geostationarySatelliteHeight, numberOfSatellites: 6)
                ],
                fieldOfView: .farAway,
                coloringMode: .accordingToOrbit,
                showOrbit: false,
                isAR: false
            )
            
        case 6:
            return Configuration(
                orbits: [
                    Orbit(normal: SCNVector3(1, 1, 1), heightAboveEarth: Constants.gpsSatelliteHeight, numberOfSatellites: 12)
                ],
                fieldOfView: .default,
                coloringMode: .accordingToVisibility,
                showOrbit: true,
                isAR: false
            )
            
        case 7:
            return Configuration(
                orbits: [
                    // [0 1 0] * rotz(55) * roty(288.85)
                    Orbit(normal: SCNVector3(0.2647, 0.5736, -0.7752), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 0, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(348.85)
                    Orbit(normal: SCNVector3(0.8037, 0.5736, -0.1584), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 15, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(48.85)
                    Orbit(normal: SCNVector3(0.5390, 0.5736, 0.6168), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 30, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(108.85)
                    Orbit(normal: SCNVector3(-0.2647, 0.5736, 0.7752), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 45, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(168.85)
                    Orbit(normal: SCNVector3(-0.8037, 0.5736, 0.1584), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 60, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(228.85)
                    Orbit(normal: SCNVector3(-0.5390, 0.5736, -0.6168), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 75, numberOfSatellites: 4)
                ],
                fieldOfView: .default,
                coloringMode: .accordingToVisibility,
                showOrbit: true,
                isAR: false
            )
            
        case 8:
            return Configuration(
                orbits: [
                    // [0 1 0] * rotz(55) * roty(288.85)
                    Orbit(normal: SCNVector3(0.2647, 0.5736, -0.7752), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 0, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(348.85)
                    Orbit(normal: SCNVector3(0.8037, 0.5736, -0.1584), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 15, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(48.85)
                    Orbit(normal: SCNVector3(0.5390, 0.5736, 0.6168), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 30, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(108.85)
                    Orbit(normal: SCNVector3(-0.2647, 0.5736, 0.7752), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 45, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(168.85)
                    Orbit(normal: SCNVector3(-0.8037, 0.5736, 0.1584), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 60, numberOfSatellites: 4),
                    
                    // [0 1 0] * rotz(55) * roty(228.85)
                    Orbit(normal: SCNVector3(-0.5390, 0.5736, -0.6168), heightAboveEarth: Constants.gpsSatelliteHeight, satellitePhaseOffsetDeg: 75, numberOfSatellites: 4)
                ],
                fieldOfView: .default,
                coloringMode: .accordingToVisibility,
                showOrbit: false,
                isAR: true
            )
            
        default:
            fatalError("Unknown page")
        }
    }
    
    static func title(for page: Int) -> String {
        switch page {
        case 1: return "🌎 Welcome!"
        case 2: return "🛰️ One lonely satellite"
        case 3: return "🛰️ More satellites 🛰️"
        case 4: return "⭕️ More orbits ⭕️"
        case 5: return "🛰️ Just the satellites"
        case 6: return "🧭 Navigation Basics"
        case 7: return "🤓 Improved navigation"
        case 8: return "🤯 Leveling up the experience"
        default: fatalError("Unknown page")
        }
    }

    @ViewBuilder
    static func text(for page: Int) -> some View {
        switch page {
        case 1:
            VStack {
                (Text("Welcome to ") + Text("Satellites").font(.system(size: 16, weight: .regular, design: .monospaced)) + Text(",\nmy _WWDC 2023 Swift Student Challenge_ submission!\nThis app will give a **step-by-step visual introduction on satellites** orbiting around our beautiful planet.\n\n"))
                Text("Three minutes is few time, so let's jump straight into the playground: **Click anywhere outside the box to get started** and explore the following:\n")
                Text("🌎 Our beautiful planet earth (try to pinch and pan!)\n")
                Text("🔄 How the planet rotates, controlling day and night!\n")
                Text("⏯️ How you can control the rotation via the ") + Text(Image(systemName: "pause.circle.fill")) + Text(" / ") + Text(Image(systemName: "play.circle.fill")) + Text(" button.\n\n")
                Text("At any time, you can **re-read the information text using the** ") + Text(Image(systemName: "info.circle.fill")) + Text(" **button**. And when you're done exploring the first page, use the ") + Text(Image(systemName: "arrow.right.circle.fill")) + Text(" button to go to the next page.")
            }
            
        case 2:
            VStack {
                Text("What you see in this step is very basic!\n\n")
                Text("There's **one single satellite** (symbolized by the red dot 🔴) circulating around the earth. The path of this satellite is called an _orbit_. And for the sake of simplicity, this app only includes circular orbits, though in general, elliptical orbits also exist!\n\n")
                Text("Play around a bit with the view to see, how this specific orbit is positioned relative to the earth and **how the satellite strictly follows the orbit**.\n\n")
                Text("Then proceed to the next page.")
            }
            
        case 3:
            VStack {
                Text("Now we're finally getting some more action!\n\n")
                Text("What you see on this page is six satellites circulating around our globe - **all on the same orbit**. Despite the same orbit being used by all satellites, there are no collisions: This is because **all satellites on one orbit move with the same velocity**.\n\n")
                Text("And there's also something else to try out on this page: You can pick a city which is then marked on the earth surface with a yellow dot (🟡) and see whether a line-of-sight (LOS) connection between the city and a specific satellite exists (🟢) or doesn't exist (🔴).\n\n")
                Text("When you're done exploring, go to the next page.")
            }
            
        case 4:
            VStack {
                Text("Now there are even more interesting orbits! 🤯\n\n")
                Text("On this page, it's not just one orbit with six satellites on it, but **three orbits which six satellites each**! And the orbits are quite different: They have a **different distance** to the earth surface and a **different orientation**.\n\n")
                Text("One thing that can be well observed in this scenario is how satellites on an orbit closer to the earth surface have a **much decreased circulation time**.\n\n")
                Text("Another interesting thing is the so-called geostationary orbit. 💡 Because satellites on this orbit have a circulation time of **exactly 24 hours**, and because it is located above the equator, satellites on this orbit **maintain the same relative position to any arbitrary point on the earth surface**. You can check this by observing how the satellites on this orbit visible from a specific city **stay constant over time**.\n\n")
                Text("Take your time to play around a bit, then proceed to the next page.")
            }
            
        case 5:
            VStack {
                Text("Just a reminder: The only thing that truly exists are the satellites 🛰️, while the orbits ⭕️ are **just a visualization tool** to better make sense of the satellite movements.\n\n")
                Text("Of course, it's possible to just draw the satellites – and that's what is done for this view. Also, instead of coloring the satellites according to their visibility from a certain point of interest, they are now **colored according to the orbit they're on**.\n\n")
                Text("Please note, that apart from the lack of orbit visualization and the color change, nothing changed compared to the last page!\n\n")
                Text("If everything's clear, go to the next page!")
            }
            
        case 6:
            VStack {
                Text("Time is probably running out and it will be hard to give a full insight into the inner mechanics of satellite navigation with **global navigation satellite systems** (GNSS) such as GPS!\n\n")
                Text("Nonetheless here's a very basic, yet super important fact: If you want to get the exact location of a point within a **four-dimensional space** (three dimensions of space 🌌 + time ⏳), **at least four satellites** must be directly visible (💡 line-of-sight - LOS) from that point **at any time**!\n\n")
                Text("On this page, you'll see our first trivial, one-orbit approach on achieving this! Check whether the four-visible-satellite criterion is fulfilled for **any city at any point in time**; then proceed to the next page.")
            }
            
        case 7:
            VStack {
                Text("That was quite easy – our first trivial approach **already fulfilled the four-satellite criterion**!\n\n")
                Text("The reality is a bit more complex though: As the localization precision rises with a higher spatial diversity, as is explained in [this Wikipedia article on the so-called Dilution of Precision (DUT)](https://en.wikipedia.org/wiki/Dilution_of_precision_(navigation)), **more sophisticated satellite constellations** are commonly used.\n\n")
                Text("For example, with the initial generation of GPS, there are **24 satellites evenly distributed across six orbits**. And exactly these orbits (and the satellites) are shown on this page – with a relative height to the earth radius that matches the reality! ⚖️\n\n")
                Text("Try to pan the view a bit to understand how the constellation works – and try to observe which satellites are visible from which city.\n\n")
                Text("When you're done, go to the final page for a little surprise! 🎉")
            }
            
        case 8:
            VStack {
                Text("Now that we've explored almost everything within the app, let's have some fun!! 🤪\n\n")
                if ARWorldTrackingConfiguration.isSupported {
                    Text("Explore the previous scene (without the orbit lines), **but now in augmented reality**.\n\n")
                    Text("Enjoy the immersion – and thank you for having a look at this app. If you want to, feel free to go back to the previous pages and play around a bit. 🎲")
                } else {
                    Text("Well, we could have fun (i. e. see the previous scene (without the orbit lines) in AR), but only if you open this app on a device that supports AR. 🥸 \n\n")
                    Text("If that's not the possible at the moment: Thanks for having a look at this app and feel free to go back to the previous pages and play around a bit. 🎲")
                }
            }
        default:
            fatalError("Unknown page")
        }
    }
}
