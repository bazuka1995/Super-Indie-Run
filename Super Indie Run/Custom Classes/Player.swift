//
//  Player.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

enum PlayerState {
    case idle, running
}

class Player: SKSpriteNode {
    
    var runFrames = [SKTexture]()
    var idleFrames = [SKTexture]()
    var jumpFrames = [SKTexture]()
    var dieFrames = [SKTexture]()
    
    var state = PlayerState.idle { // initialise player as idle
        willSet {
            animate(for: newValue)
        }
    }
    
    func loadTextures() { // load all images for frames, initialise all frames for player
        idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerIdleAtlas), withName: GameConstants.StringConstants.idlePrefixKey)
        runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRunAtlas), withName: GameConstants.StringConstants.runPrefixKey)
        jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerJumpAtlas), withName: GameConstants.StringConstants.jumpPrefixKey)
        dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDieAtlas), withName: GameConstants.StringConstants.diePrefixKey)
    }
    
    func animate(for state: PlayerState) {
        removeAllActions() //dont stack actions on top of each other
        switch state {
        case .idle:
            self.run(SKAction.repeatForever(SKAction.animate(withNormalTextures: idleFrames, timePerFrame: 0.05, resize: true, restore: true))) // restore determines what happens next after the action stops. ture --> texture will be reset to the texture before the animation
        case .running:
            self.run(SKAction.repeatForever(SKAction.animate(withNormalTextures: runFrames, timePerFrame: 0.05, resize: true, restore: true)))
        }
    }
    
}
