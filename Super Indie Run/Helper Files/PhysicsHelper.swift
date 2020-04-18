//
//  PhysicsHelper.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

class PhysicsHelper {
    
    static func addPhysicsBody(to sprite: SKSpriteNode, with name: String) {
        
        switch name {
        case GameConstants.StringConstants.playerName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height)) //create a physics body rectangle for the player width is slightly smaller than the player size)
            sprite.physicsBody!.restitution = 0.0 // player doesnt keep energy when hitting other physics objects
            sprite.physicsBody!.allowsRotation = false
        default:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size) // if there isnt a specific node, we add a generic rectangle physics body
        }
        
    }
    
}
