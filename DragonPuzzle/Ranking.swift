//
//  Ranking.swift
//  DragonPuzzle
//
//  Created by Yoshiki Izumi on 2020/08/12.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import SpriteKit
import GameplayKit

class RankingScene : SKScene {
    var homeButton : SKLabelNode = SKLabelNode(text: "Home")
    var headerLabel : SKLabelNode = SKLabelNode(text: "Ranking explanation")
    var pointLabels : [SKLabelNode] = [
        SKLabelNode(),SKLabelNode(),SKLabelNode(),SKLabelNode(),SKLabelNode(),
        SKLabelNode(),SKLabelNode(),SKLabelNode(),SKLabelNode(),SKLabelNode()
    ]

    override func didMove(to view: SKView) {
        var y : CGFloat = 20.0
        
        for pointLabel in pointLabels {
            pointLabel.position.x = view.frame.width / 2
            pointLabel.position.y = view.frame.height / 100 * y
            pointLabel.text = "testtest:12345"
            pointLabel.name = "point"
            addChild(pointLabel)
            y += 6
        }
        
        headerLabel.position.x = view.frame.width / 2
        headerLabel.position.y = view.frame.height / 100 * y
        headerLabel.name = "headerLabel"
        addChild(headerLabel)

        y += 6
        
        homeButton.position.x = view.frame.width / 2
        homeButton.position.y = view.frame.height / 100 * y
        homeButton.name = "homeButton"
        addChild(homeButton)

    }

//    init(point : Int) {
//        super.init()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

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
