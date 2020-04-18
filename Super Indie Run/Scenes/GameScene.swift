//
//  GameScene.swift
//  Super Indie Run
//
//  Created by Dov Royal on 17/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

enum GameState { // set the gamestate so that we know when to stop the scrolling/start the scrolling
    case ready, ongoing, pause, finished
}

class GameScene: SKScene {
    
    var worldLayer: Layer!
    var backgroundLayer: RepeatingLayer!
    var mapNode: SKNode!
    var tileMap: SKTileMapNode! //! --> Wont be needing an initialiser but make sure they have already been initialised
    
    var lastTime: TimeInterval = 0 // keep track of time and make sure that we always update the correct position
    var dt: TimeInterval = 0 // and have a smooth movement
    
    var gameState = GameState.ready
    
    override func didMove(to view: SKView) {
        createLayers() //
    }
    
    func createLayers() {
        worldLayer = Layer()
        worldLayer.zPosition = GameConstants.ZPositions.worldZ
        addChild(worldLayer) // add worldlayer to the scene as a child
        worldLayer.layerVelocity = CGPoint(x: -200.0, y: 0.0) // declare velocity of worldlayer --> tell our layer how much it should move using x and y values. => -200 because it moves to the left
        
        backgroundLayer = RepeatingLayer()
        backgroundLayer.zPosition = GameConstants.ZPositions.farBGZ
        addChild(backgroundLayer) // add layer to the gamescene
        
        for i in 0...1 { //create a spritenode initialised with background image
            let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[0])
            backgroundImage.name = String(i) // names the sprite 0 and 1
            backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0) // scale image to the whole screen, width = false because we are scaling the height, multiplier = 1 because we want the image to fill the whole screen
            backgroundImage.anchorPoint = CGPoint.zero // place image in bottom left corner
            backgroundImage.position = CGPoint(x: 0.0 + CGFloat(i) * backgroundImage.size.width, y: 0.0) // position second image after first one. First loop i = 0, so position will be 0. second image will be offset by the width of the first image
            backgroundLayer.addChild(backgroundImage)
        }
        
        backgroundLayer.layerVelocity = CGPoint(x: -100.0, y: 0.0) // set velocity of background. speed is half the map velocity to create paralax effect
        
        load(level: "Level_0-1")
    }
    
    func load(level: String) {
        if let levelNode = SKNode.unarchiveFromFile(file: level) {
            mapNode = levelNode
            worldLayer.addChild(mapNode) //add map to game
            loadTileMap()
        }
    }
    
    func loadTileMap() {
        if let groundTiles = mapNode.childNode(withName: GameConstants.StringConstants.groundTilesName) as? SKTileMapNode {
            tileMap = groundTiles
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0) // false because use height to scale --> make sure that the level scales correctly depending on the size of the screen
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .ready:
            gameState = .ongoing // start the game
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // called when touches on screen have stopped
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) { // Parameter = current system time.
        // Called before each frame is rendered
        
        if lastTime > 0 {
            dt = currentTime - lastTime // get the time since the last call
        } else {
            dt = 0
        }
        lastTime = currentTime // next time it is called, it will have the time of the last function call
        
        if gameState == .ongoing { // level will only scroll when the game is started by user
            worldLayer.update(dt) // always having an update since the function was called last time --> smooth animation of worldlayer
            backgroundLayer.update(dt)
        }
        
    }
}
