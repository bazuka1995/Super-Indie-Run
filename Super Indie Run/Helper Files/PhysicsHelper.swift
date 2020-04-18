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
    
    static func addPhysicsBody(to tileMap: SKTileMapNode, tileInfo: String) {
        let tileSize = tileMap.tileSize // how big the tiles in our map
        
        for row in 0..<tileMap.numberOfRows {
            var tiles = [Int]()
            for col in 0..<tileMap.numberOfColumns {
                let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                let isUsedTile = tileDefinition?.userData?[tileInfo] as? Bool
                if isUsedTile ?? false {
                    tiles.append(1)
                } else {
                    tiles.append(0)
                }
            }
            if tiles.contains(1) {
                var platform = [Int] ()
                for (index,tile) in tiles.enumerated() { //adds tiles to the platform array
                    if tile == 1 && index < (tileMap.numberOfColumns - 1) { // if this is true, next tile is a ground tile and we arent at the end of the map yet
                        platform.append(index)
                    } else if !platform.isEmpty {
                        let x = CGFloat(platform[0]) * tileSize.width //first index of platform * width of tiles
                        let y = CGFloat(row) * tileSize.height // row * height of tile
                        let tileNode = GroundNode(with: CGSize(width: tileSize.width * CGFloat(platform.count), height: tileSize.height)) // we check the number of tiles in our platform and * width of 1 platform
                        tileNode.position = CGPoint(x: x, y: y)
                        tileNode.anchorPoint = CGPoint.zero
                        tileMap.addChild(tileNode)
                        platform.removeAll()
                    }
                }
            }
        }
    }
    
}
