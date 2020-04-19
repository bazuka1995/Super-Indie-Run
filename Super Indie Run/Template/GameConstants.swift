//
//  GameConstants.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import Foundation
import CoreGraphics

struct GameConstants {
    
    struct PhysicsCategories {
        static let noCategory: UInt32 = 0 // for physics bodies with no specific categories
        static let allCategory: UInt32 = UInt32.max
        static let playerCategory: UInt32 = 0x1 // 1
        static let groundCategory: UInt32 = 0x1 << 1 // 10
        static let finishCategory: UInt32 = 0x1 << 2 // 100
        static let collectibleCategory: UInt32 = 0x1 << 3 // 1000
        static let enemyCategory: UInt32 = 0x1 << 4
        static let frameCategory: UInt32 = 0x1 << 5
        static let ceilingCategory: UInt32 = 0x1 << 6
    }
    
    struct ZPositions { // what elements are showed in front of other elements. Higher z position will be displayed in front of lower ones
        static let farBGZ: CGFloat = 0 // background image
        static let closeBGZ: CGFloat = 1 // close images
        static let worldZ: CGFloat = 2
        static let objectZ: CGFloat = 3
        static let playerZ: CGFloat = 4
        static let hudZ: CGFloat = 5
    }
    
    struct StringConstants {
        static let groundTilesName = "Ground Tiles"
        static let worldBackgroundNames = ["DesertBackground", "GrassBackground"]
        static let playerName = "Player"
        static let playerImageName = "Idle_0"
        static let groundNodeName = "GroundNode"
        
        static let playerIdleAtlas = "Player Idle Atlas"
        static let playerRunAtlas = "Player Run Atlas"
        static let playerJumpAtlas = "Player Jump Atlas"
        static let playerDieAtlas = "Player Die Atlas"
        static let idlePrefixKey = "Idle_"
        static let runPrefixKey = "Run_"
        static let jumpPrefixKey = "Jump_"
        static let diePrefixKey = "Die_"
        
        static let jumpUpActionKey = "JumpUp"
        static let brakeDescendActionKey = "BrakeDescend"
    }
    
}
