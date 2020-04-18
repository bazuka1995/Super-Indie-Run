//
//  GroundNode.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

class GroundNode: SKSpriteNode {
    
    var isBodyActivated: Bool = false { // property will decide whether physics body is active depending on player above or below node
        didSet {
            physicsBody = isBodyActivated ? activatedBody : nil
        }
    }
    
    private var activatedBody: SKPhysicsBody?
    
    init(with size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        let bodyInitialPoint = CGPoint(x: 0.0, y: size.height) // get top left
        let bodyEndPoint = CGPoint(x: size.width, y: size.height) // and top right of our ground node
        
        activatedBody = SKPhysicsBody(edgeFrom: bodyInitialPoint, to: bodyEndPoint)
        activatedBody!.restitution = 0.0
        
        physicsBody = isBodyActivated ? activatedBody : nil
        
        name = GameConstants.StringConstants.groundNodeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
