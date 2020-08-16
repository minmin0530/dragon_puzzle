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
    var pointLabel : SKLabelNode = SKLabelNode()
    
    var dragon : [SKSpriteNode] = []

    override func didMove(to view: SKView) {
        homeButton.position.x = view.frame.width / 2
        homeButton.position.y = view.frame.height / 10 * 7
        homeButton.name = "homeButton"
        addChild(homeButton)

        pointLabel.position.x = view.frame.width / 2
        pointLabel.position.y = view.frame.height / 10 * 3
        pointLabel.name = "point"
        addChild(pointLabel)
        
        var x: CGFloat = -100
        for d in dragon {
            d.position.x = view.frame.width / 2 + x
            d.position.y = view.frame.height / 2
            x += 90.0
        }
    }

    func setPoint(point: Int64) {
        pointLabel.text = "point:" + point.description
    }
    func setDragon(dragonNum: Int) {
        for _ in 0...(dragonNum - 1) {
            let d: SKSpriteNode = SKSpriteNode(imageNamed: "dragonRight")
            d.xScale = 0.05
            d.yScale = 0.05
            addChild(d)
            dragon.append( d )
        }
    }
    func setBadge(badge: Int) {
        
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
