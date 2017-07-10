//
//  ViewController.swift
//  PhysicsTest
//
//  Created by Henk van der Spek on 22/06/2017.
//  Copyright © 2017 Henk van der Spek. All rights reserved.
//

import UIKit
import SceneKit

private extension Color {
    static var earth: Color {
        return Color(red: 4/255, green: 120/255, blue: 1)
    }
    static var moon: Color {
        return Color(red: 94/255, green: 94/255, blue: 94/255)
    }
}

private extension Orbit {
    static var earth: Orbit {
        return Orbit(duration: 0, axis: 0, distance: 0)
    }
    static var moon: Orbit {
        return Orbit(duration: 10, axis: 5.14, distance: 384.405 / 50.0)
    }
}

private extension PhyiscalBody {
    static var earth: PhyiscalBody {
        return PhyiscalBody(radius: 6.378 / 2.0, color: Color.earth)
    }
    static var moon: PhyiscalBody {
        return PhyiscalBody(radius: PhyiscalBody.earth.radius / 4.0, color: Color.moon)
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: SCNView! {
        didSet {
            let moon = Moon(body: PhyiscalBody.moon, orbit: Orbit.moon)
            let earth = Planet(body: PhyiscalBody.earth, orbit: Orbit.earth, moons: [moon])
            let solarSystem = SolarSystem(planets: [earth])
            let scene = solarSystem.scene
            sceneView.scene = scene
        }
    }
}
