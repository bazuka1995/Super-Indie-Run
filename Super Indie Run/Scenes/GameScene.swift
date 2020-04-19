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
    
    var gameState = GameState.ready {
        willSet {
            switch newValue {
            case .ongoing: // happen when starting game
                player.state = .running
            case .finished:
                player.state = .idle
            default:
                break
            }
        }
    }
    
    var player: Player!
    
    var touch = false // whether or not a finger is touching the screen
    var brake = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -6.0)
        
        createLayers()
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
            PhysicsHelper.addPhysicsBody(to: tileMap, tileInfo: "ground")
            for child in groundTiles.children {
                if let sprite = child as? SKSpriteNode, sprite.name != nil {
                    ObjectHelper.handleChild(sprite: sprite, name: sprite.name!)
                }
            }
        }
        
        addPlayer()
    }
    
    func addPlayer() { //load level, then tilemap, then player
        player = Player(imageNamed: GameConstants.StringConstants.playerImageName)
        player.scale(to: frame.size, width: false, multiplier: 0.1) //make player 0.1 times the size of the screen
        player.name = GameConstants.StringConstants.playerName
        PhysicsHelper.addPhysicsBody(to: player, with: player.name!)
        player.position = CGPoint(x: frame.midX/2.0, y: frame.midY)
        player.zPosition = GameConstants.ZPositions.playerZ
        player.loadTextures()
        player.state = .idle
        addChild(player)
        addPlayerActions()
    }
    
    func addPlayerActions() {
        let up = SKAction.moveBy(x: 0.0, y: frame.size.height/4, duration: 0.4)
        up.timingMode = .easeOut // slow down the action at the end
        
        player.createUserData(entry: up, forKey: GameConstants.StringConstants.jumpUpActionKey) // added the action to playersprite node
        
        let move = SKAction.moveBy(x: 0.0, y: player.size.height, duration: 0.4)
        let jump = SKAction.animate(with: player.jumpFrames, timePerFrame: 0.4/Double(player.jumpFrames.count))
        let group = SKAction.group([move, jump])
        
        player.createUserData(entry: group, forKey: GameConstants.StringConstants.brakeDescendActionKey)
    }
    
    func jump() {
        player.airBorne = true
        player.turnGravity(on: false) // temp turn player gravity off so that he can jump
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
            if self.touch {
                self.player.run(self.player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction, completion: {
                    self.player.turnGravity(on: true)
                })
            }
        }
    }
    
    func brakeDescend() {
        brake = true
        player.physicsBody!.velocity.dy = 0.0
        
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.brakeDescendActionKey) as! SKAction)
    }
    
    func handleEnemyContact() {
        die(reason: 0)
    }
    
    func die(reason: Int) {
        gameState = .finished
        player.turnGravity(on: false)
        let deathAnimation: SKAction!
        
        switch reason {
        case 0:
            deathAnimation = SKAction.animate(with: player.dieFrames, timePerFrame: 0.1, resize: true, restore: true)
        default:
            deathAnimation = SKAction.animate(with: player.dieFrames, timePerFrame: 0.1, resize: true, restore: true)
        }
        
        player.run(deathAnimation) {
            self.player.removeFromParent() // remove player from screen
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .ready:
            gameState = .ongoing // start the game
        case .ongoing:
            touch = true
            if !player.airBorne {
                jump()
            } else if !brake {
                brakeDescend()
            }
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // called when touches on screen have stopped
        touch = false
        player.turnGravity(on: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = false
        player.turnGravity(on: true)
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
    
    override func didSimulatePhysics() { // track position of player and activate or deactivate physics body of node
        for node in tileMap[GameConstants.StringConstants.groundNodeName] {
            if let groundNode = node as? GroundNode {
                let groundY = (groundNode.position.y + groundNode.size.height) * tileMap.yScale
                let playerY = player.position.y - player.size.height/3
                groundNode.isBodyActivated = playerY > groundY // if y position of player is higher than y position of ground node, physics is activated
            }
        }
    }
    
}

extension GameScene: SKPhysicsContactDelegate { // what happens when contacts occur
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask // the parameter contains the two bodys that have made contact, then we create a contact mask containing the bit masks of the two bodies
        
        switch contactMask {
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory: // check for contact between ground and player
            player.airBorne = false
            brake = false
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.finishCategory:
            gameState = .finished
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.enemyCategory:
            handleEnemyContact()
        default:
            break
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory: // cant jump if fallen off a ledge
            player.airBorne = true
        default:
            break
        }
    }
    
}
