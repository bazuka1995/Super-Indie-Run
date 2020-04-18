//
//  SKNode+Extensions.swift
//  Super Indie Run
//
//  Created by Dov Royal on 18/4/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

import SpriteKit

extension SKNode {
    
    class func unarchiveFromFile(file: String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let url = URL(fileURLWithPath: path)
            do {
                let sceneData = try Data(contentsOf: url, options: .mappedIfSafe)
                let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
                archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! SKNode
                archiver.finishDecoding()
                return scene
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
    
    func scale(to screenSize: CGSize, width: Bool, multiplier: CGFloat) { // scale a certain object (SKNode) --> use width or height to scale the node depending on other node size
        let scale = width ? (screenSize.width * multiplier) / self.frame.size.width : (screenSize.height * multiplier) / self.frame.size.height
        self.setScale(scale)
    }
    
    func turnGravity(on value: Bool) { // enables easy changing of gravity
        physicsBody?.affectedByGravity = value
    }
    
    func createUserData(entry: Any, forKey key: String) {
        if userData == nil { // Checks to see if the user's data exists
            let userDataDictionary = NSMutableDictionary()
            userData = userDataDictionary
        }
        
        userData!.setValue(entry, forKey: key)
    }
}
