//
//  AnimationHelper.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

class AnimationHelper {
    
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture] {
        var textures = [SKTexture] ()
        for index in 0..<atlas.textureNames.count {
            let textureName = name + String(index) // build photo names
            textures.append(atlas.textureNamed(textureName)) // get the texture from the atlas
        }
        return textures
    }
    
}
