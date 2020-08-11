//
//  ResultScene.swift
//  DragonPuzzle
//
//  Created by izumiyoshiki-imac on 2020/08/11.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import SpriteKit
import GameplayKit

class ResultScene : SKScene {
    var homeButton : SKLabelNode = SKLabelNode(text: "Home")
    
    override func didMove(to view: SKView) {
        homeButton.position.x = view.frame.width / 2
        homeButton.position.y = view.frame.height / 10 * 5
        homeButton.name = "homeButton"
        addChild(homeButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.location(in:self)
            if self.atPoint(location).name == "homeButton" {
                let scene = MenuScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                self.view!.presentScene(scene)
            }
            

        }
    }
}
