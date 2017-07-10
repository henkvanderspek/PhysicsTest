//
//  SolarSystem.swift
//  PhysicsTest
//
//  Created by Henk van der Spek on 22/06/2017.
//  Copyright © 2017 Henk van der Spek. All rights reserved.
//

import SceneKit

struct PhyiscalBody {
    let radius: Float
    let color: Color
    var diamater: Float {
        return radius * 2
    }
}

struct Orbit {
    let duration: TimeInterval
    let axis: Float
    let distance: Float
}

struct Color {
    let red: Float
    let green: Float
    let blue: Float
}

struct Planet {
    let body: PhyiscalBody
    let orbit: Orbit
    let moons: [Moon]
}

struct Moon {
    let body: PhyiscalBody
    let orbit: Orbit
}

struct SolarSystem {
    var planets: [Planet]
}
