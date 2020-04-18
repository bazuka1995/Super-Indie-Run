//
//  GameScene.swift
//  Super Indie Run
//
//  Created by Dov Royal on 17/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var mapNode: SKNode!
    var tileMap: SKTileMapNode! //!--> Wont be needing an initialiser but make sure they have already been initialised
    
    override func didMove(to view: SKView) {
        load(level: "Level_0-1")
    }
    
    func load(level: String) {
        if let levelNode = SKNode.unarchiveFromFile(file: level) {
            mapNode = levelNode
            addChild(mapNode) //add map to game
            loadTileMap()
        }
    }
    
    func loadTileMap() {
        if let groundTiles = mapNode.childNode(withName: "Ground Tiles") as? SKTileMapNode {
            tileMap = groundTiles
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0) // false because use height to scale --> make sure that the level scales correctly depending on the size of the screen
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
