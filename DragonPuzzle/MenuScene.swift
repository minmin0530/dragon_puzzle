//
//  MenuScene.swift
//  DragonPuzzle
//
//  Created by izumiyoshiki-imac on 2020/08/11.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import SpriteKit
import GameplayKit
enum Mode {
    case collectBadge
    case timeAttack
    case free
}

class MenuScene : SKScene {
    var collectBadgeButton : SKLabelNode = SKLabelNode(text: "Collect Badge")
    var timeAttackButton : SKLabelNode = SKLabelNode(text: "Time Attack")
    var freeModeButton : SKLabelNode = SKLabelNode(text: "Free Mode")
    
    override func didMove(to view: SKView) {
        collectBadgeButton.position.x = view.frame.width / 2
        collectBadgeButton.position.y = view.frame.height / 10 * 7
        collectBadgeButton.name = "collectionBadgeButton"
        addChild(collectBadgeButton)
        timeAttackButton.position.x = view.frame.width / 2
        timeAttackButton.position.y = view.frame.height / 10 * 5
        timeAttackButton.name = "timeAttackButton"
        addChild(timeAttackButton)
        freeModeButton.position.x = view.frame.width / 2
        freeModeButton.position.y = view.frame.height / 10 * 3
        freeModeButton.name = "freeModeButton"
        addChild(freeModeButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.location(in:self)
            if self.atPoint(location).name == "freeModeButton" {
                let scene = GameScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                scene.setMode(m: Mode.free)
                self.view!.presentScene(scene)
            }
            
            if self.atPoint(location).name == "timeAttackButton" {
                let scene = GameScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                scene.setMode(m: Mode.timeAttack)
                self.view!.presentScene(scene)
            }

            if self.atPoint(location).name == "collectionBadgeButton" {
                let scene = GameScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                scene.setMode(m: Mode.collectBadge)
                self.view!.presentScene(scene)
            }

        }
    }
}
