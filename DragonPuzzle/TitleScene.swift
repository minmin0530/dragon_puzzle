//
//  TitleScene.swift
//  DragonPuzzle
//
//  Created by Yoshiki Izumi on 2020/07/30.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//


import SpriteKit
import GameplayKit

class TitleScene : SKScene {
    var startButton : SKLabelNode = SKLabelNode(text: "GAME START")
    var r : CGFloat = 1.0
    var g : CGFloat = 1.0
    var b : CGFloat = 1.0
    override func didMove(to view: SKView) {
        let title : SKSpriteNode = SKSpriteNode(imageNamed: "title")
        title.position.y = view.frame.height / 10 * 9
        title.position.x = view.frame.width / 2
        title.xScale = 0.4
        title.yScale = 0.4
        addChild(title)
        let dragon : SKSpriteNode = SKSpriteNode(imageNamed: "dragonTitle")
        dragon.position.y = view.frame.height / 2
        dragon.position.x = view.frame.width / 2
        dragon.xScale = 0.4 * 0.606
        dragon.yScale = 0.4 * 0.606
        addChild(dragon)
        
        startButton.fontName = "Arial Bold"
        startButton.position.x = view.frame.width / 2
        startButton.position.y = view.frame.height / 10
        startButton.colorBlendFactor = 1.0
        startButton.color = UIColor.red
        startButton.name = "startButton"
        addChild(startButton)
        
        
    }
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.location(in:self)
            if self.atPoint(location).name == "startButton" {
                let scene = MenuScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                self.view!.presentScene(scene)
            }
        }

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    let s : CGFloat = 0.02

    override func update(_ currentTime: TimeInterval) {
        startButton.colorBlendFactor = 1.0
        startButton.color = UIColor.init(red: r, green: g, blue: b, alpha: 1.0)

        if r > 0.0 && g == 1.0 && b == 1.0 {
            r -= s
        }
        if g > 0.0 && r <= 0.0 && b == 1.0{
            g -= s
        }
        if b > 0.0 && r <= 0.0 && g <= 0.0 {
            b -= s
        }
        
        if r < 1.0 && g <= 0.0 && b <= 0.0 {
            r += s
        }
        if r == 1.0 && g < 1.0 && b <= 0.0 {
            g += s
        }
        if r == 1.0 && g == 1.0 && b < 1.0 {
            b += s
        }
    }
}
