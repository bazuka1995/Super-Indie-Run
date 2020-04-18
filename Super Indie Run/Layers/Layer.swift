//
//  Layer.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

class Layer: SKNode {
    var layerVelocity = CGPoint.zero
    
    func update(_ delta: TimeInterval) {
        for child in children { // all children of our layer node
            updateNodesGlobal(delta, childNode: child) // change position with respect of child node
        }
    }
    
    func updateNodesGlobal(_ delta: TimeInterval, childNode: SKNode) {
        let offset = layerVelocity * CGFloat(delta) // take the velocity of our layer * time passed --> smooth movement of layer irrespective of current fps
        childNode.position += offset // update position of child node
        updateNodes(delta, childNode: childNode)
    }
    
    func updateNodes(_ delta: TimeInterval, childNode: SKNode) {
        //overwritten in subclasses
    }
}
