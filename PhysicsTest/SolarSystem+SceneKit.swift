//
//  SolarSystem+SceneKit.swift
//  PhysicsTest
//
//  Created by Henk van der Spek on 24/06/2017.
//  Copyright © 2017 Henk van der Spek. All rights reserved.
//

import SceneKit

private extension UIColor {
    convenience init(color: Color) {
        self.init(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1)
    }
}

private extension SCNNode {
    func runOrbit(_ orbit: Orbit) {
        if orbit.duration <= 0 { return }
        if orbit.distance <= 0 { return }
        let degrees = Float(360.0/orbit.duration)
        let angle = CGFloat(GLKMathDegreesToRadians(degrees))
        let rotate = SCNAction.rotateBy(x: 0, y: angle, z: 0, duration: 1.0)
        let forever = SCNAction.repeatForever(rotate)
        runAction(forever, forKey: nil)
    }
}

private extension PhyiscalBody {
    var node: SCNNode {
        let geometry = SCNSphere(radius: CGFloat(radius))
        geometry.firstMaterial?.diffuse.contents = UIColor(color: color)
        geometry.isGeodesic = true
        return SCNNode(geometry: geometry)
    }
}

private extension Planet {
    var node: SCNNode {
        let bnode = body.node
        bnode.position = SCNVector3Make(0, 0, orbit.distance)
        let center = SCNNode()
        center.rotation = SCNVector4Make(0, 0, 1, GLKMathDegreesToRadians(orbit.axis))
        center.addChildNode(bnode)
        center.runOrbit(orbit)
        for moon in moons {
            let n = moon.node
            center.addChildNode(n)
        }
        return center
    }
}

private extension Moon {
    var node: SCNNode {
        // Merge with duplicate stuff from above
        let bnode = body.node
        bnode.position = SCNVector3Make(0, 0, orbit.distance)
        let center = SCNNode()
        center.rotation = SCNVector4Make(0, 0, 1, GLKMathDegreesToRadians(orbit.axis))
        center.addChildNode(bnode)
        center.runOrbit(orbit)
        return center
    }
}

extension SolarSystem {
    var scene: SCNScene {
        let scene = SCNScene()
        let camera = SCNNode.camera()
        let sun = SCNNode.sun()
        camera.addChildNode(sun)
        scene.rootNode.addChildNode(camera)
        let center = SCNNode()
        for planet in planets {
            center.addChildNode(planet.node)
        }
        scene.rootNode.addChildNode(center)
        return scene
    }
}

extension SCNNode {
    static func camera() -> SCNNode {
        let node = SCNNode()
        node.camera = SCNCamera()
        node.position = SCNVector3Make(0, 0, 30)
        node.rotation = SCNVector4Make(1, 0, 0, -atan2f(node.position.y, node.position.z))
        return node
    }
    static func sun() -> SCNNode {
        let light = SCNLight()
        light.type = .omni
        let node = SCNNode()
        node.light = light
        return node
    }
}
