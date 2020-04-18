//
//  RepeatingLayer.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

class RepeatingLayer: Layer {
    
    override func updateNodes(_ delta: TimeInterval, childNode: SKNode) { // check whether a child node has moved so far to the left its no longer visible
        if let node = childNode as? SKSpriteNode {
            if node.position.x <= -(node.size.width)  { // x position of the node is on the negative x scale => no longer on the screen
                if node.name == "0" && self.childNode(withName: "1") != nil || node.name == "1" && self.childNode(withName: "0") != nil {
                    node.position = CGPoint(x: node.position.x + node.size.width * 2, y: node.position.y) // move the x position of the node by double of its width (double because there are two images)
                }
            }
        }
    }
    
}
