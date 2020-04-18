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
    
    struct ZPositions { // what elements are showed in front of other elements. Higher z position will be displayed in front of lower ones
        static let farBGZ: CGFloat = 0 // background image
        static let closeBGZ: CGFloat = 1 // close images
        static let worldZ: CGFloat = 2
        static let objectZ: CGFloat = 3
        static let playerZ: CGFloat = 4
        static let hudZ: CGFloat = 5
    }
    
}
