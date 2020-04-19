//
//  ObjectHelper.swift
//  Super Indie Run
//
//  Created by Dov Royal on 19/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

class ObjectHelper {
    
    static func handleChild(sprite: SKSpriteNode, name: String) {
        switch name {
        case GameConstants.StringConstants.finishLineName:
            PhysicsHelper.addPhysicsBody(to: sprite, with: name)
        default:
            break
        }
    }
    
}
