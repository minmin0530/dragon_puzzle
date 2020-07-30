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
        dragon.xScale = 0.4
        dragon.yScale = 0.4
        addChild(dragon)
        
        
    }
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = GameScene(size: self.scene!.size)
        scene.scaleMode = .aspectFill
        self.view!.presentScene(scene)
        
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
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
