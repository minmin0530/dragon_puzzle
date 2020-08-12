//
//  GameScene.swift
//  DragonPuzzle
//
//  Created by Yoshiki Izumi on 2020/07/29.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class Element {
    var colorNumber: Int?
    var numberNumber: Int?
    var shapeNumber: Int?
    var shape: SKSpriteNode?
    var number: SKSpriteNode?
    var shapeTexture: SKTexture?
    var numberTexture: SKTexture?
    var color: UIColor?
    var x: CGFloat?
    var deleteY: CGFloat?
    var fallY: CGFloat = 0.0
    var select: Bool = false
    var delete: Bool = false
    func draw() {
        
    }
}

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    var dragonLeft: SKSpriteNode = SKSpriteNode(imageNamed: "dragonLeft")
    var dragonRight: SKSpriteNode = SKSpriteNode(imageNamed: "dragonRight")

    var elements : [Element] = []
    var elementScale : CGFloat = 0.5
    var sceneHeightCenter : CGFloat = 300.0
    var sceneWidthCenter : CGFloat = 300.0
    
    var gameFinish: SKSpriteNode = SKSpriteNode(imageNamed: "gamefinish")
    
    var pointLabel : SKLabelNode = SKLabelNode(text: "point")
    var point : Int64 = 0
    var timeLabel : SKLabelNode = SKLabelNode(text: "time")
    var time : Int64 = 0
    var specialShape : SKTexture?
    var specialNumber: SKTexture?
    var specialColor : UIColor?
    var specialSpriteShape : SKSpriteNode?
    var specialSpriteNumber : SKSpriteNode?
    var specialSize : Int = 0
    
    var points = [CGPoint(x:0.0, y:0.0),CGPoint(x: 1.0, y:0.0)]
    var line : SKShapeNode?

    var mode : Mode?
    func setMode(m : Mode) {
        mode = m
    }
    func getColor(num: Int) -> UIColor {
        if      num == 0 { return UIColor.red }
        else if num == 1 { return UIColor.green }
        else if num == 2 { return UIColor.cyan }
        else if num == 3 { return UIColor.yellow }
        else             { return UIColor.white }
    }
    func getNumber(num: Int) -> SKTexture {
        
        if      num == -1 { return SKTexture(imageNamed: "0") }
        else if num == 0 { return SKTexture(imageNamed: "1") }
        else if num == 1 { return SKTexture(imageNamed: "2") }
        else if num == 2 { return SKTexture(imageNamed: "3") }
        else if num == 3 { return SKTexture(imageNamed: "4") }
        else             { return SKTexture(imageNamed: "5") }
    }
    func getShape(num: Int) -> SKTexture {
        if      num == -1 { return SKTexture(imageNamed: "nil") }
        else if num == 0 { return SKTexture(imageNamed: "circle") }
        else if num == 1 { return SKTexture(imageNamed: "heart") }
        else if num == 2 { return SKTexture(imageNamed: "quad") }
        else if num == 3 { return SKTexture(imageNamed: "star") }
        else             { return SKTexture(imageNamed: "hexagon") }
    }
    func initElement(e: Element) {
        e.colorNumber = Int.random(in: 0...2)
        e.numberNumber = Int.random(in: 0...2)
        e.shapeNumber = Int.random(in: 0...2)
        e.color = getColor(num: e.colorNumber!)
        e.numberTexture = getNumber(num: e.numberNumber!)
        e.shapeTexture = getShape(num: e.shapeNumber!)
        e.number?.texture = e.numberTexture
        e.shape?.texture = e.shapeTexture
        e.shape?.colorBlendFactor = 1.0
        e.shape?.color = e.color!
        e.shape?.zPosition = 1
        e.number?.zPosition = 2
//        if e.color == UIColor.white || e.color == UIColor.yellow {
            e.number?.colorBlendFactor = 1.0
            e.number?.color = UIColor.black
//        }
        e.number?.position.x = CGFloat(e.x!)
        e.number?.position.y = CGFloat( elementScale * 1500)
        e.shape?.position.x =  CGFloat(e.x!)
        e.shape?.position.y =  CGFloat( elementScale * 1500)
        e.shape?.xScale = elementScale
        e.shape?.yScale = elementScale
        e.number?.xScale = elementScale
        e.number?.yScale = elementScale
        e.delete = false
        e.select = false
    }
    func initScaleSelectElement(e: Element) {
        e.shape?.xScale = elementScale
        e.shape?.yScale = elementScale
        e.number?.xScale = elementScale
        e.number?.yScale = elementScale
        e.delete = false
        e.select = false
    }
    
    func addPoint(p: Int) {
        if p == 1 {
            point += 1
        } else if p == 2 {
            point += 10
        } else if p == 3 {
            point += 100
        } else if p == 4 {
            point += 1000
        } else if p == 5 {
            point += 10000
        } else if p == 6 {
            point += 100000
        } else if p == 7 {
            point += 1000000
        } else if p == 8 {
            point += 10000000
        } else if p == 9 {
            point += 100000000
        } else if p == 10 {
            point += 1000000000
        } else if p == 11 {
            point += 10000000000
        } else if p == 12 {
            point += 100000000000
        } else if p == 13 {
            point += 1000000000000
        } else if p == 14{
            point += 10000000000000
        } else {
            point += 99999999999999
        }
    }
    
    var player: AVAudioPlayer?
    var select: AVAudioPlayer?
    let selectSoundURL = Bundle.main.url(forResource:"select", withExtension: "mp3")
    override func didMove(to view: SKView) {
        
        let soundURL = Bundle.main.url(forResource:"bgm", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.numberOfLoops = -1   // ループ再生する
            player?.prepareToPlay()      // 即時再生させる
            player?.play()               // BGMを鳴らす
        } catch {
            print("error...")
        }


        
        elementScale = view.frame.size.height / 2000.0
        sceneHeightCenter = view.frame.size.height / 2.0
        sceneWidthCenter = view.frame.size.width / 2.0
        for y in -3...4 {
        for x in -2...2 {
            let e = Element()
            
            e.colorNumber = Int.random(in: 0...2)
            e.numberNumber = Int.random(in: 0...2)
            e.shapeNumber = Int.random(in: 0...2)
            e.color = getColor(num: e.colorNumber!)
            e.numberTexture = getNumber(num: e.numberNumber!)
            e.shapeTexture = getShape(num: e.shapeNumber!)
            e.shape = SKSpriteNode(texture: e.shapeTexture)
            e.number = SKSpriteNode(texture: e.numberTexture)
            e.shape?.colorBlendFactor = 1.0
            e.shape?.color = e.color!
            e.shape?.zPosition = 1
            e.number?.zPosition = 2
//            if e.color == UIColor.white || e.color == UIColor.yellow {
                e.number?.colorBlendFactor = 1.0
                e.number?.color = UIColor.black
//            }
            e.x                  = CGFloat(CGFloat(x) * 150.0 * elementScale + sceneWidthCenter)
            e.number?.position.x = CGFloat(CGFloat(x) * 150.0 * elementScale + sceneWidthCenter)
            e.number?.position.y = CGFloat(CGFloat(y) * 150.0 * elementScale + sceneHeightCenter)
            e.shape?.position.x =  CGFloat(CGFloat(x) * 150.0 * elementScale + sceneWidthCenter)
            e.shape?.position.y =  CGFloat(CGFloat(y) * 150.0 * elementScale + sceneHeightCenter)
            e.shape?.xScale = elementScale
            e.shape?.yScale = elementScale
            e.number?.xScale = elementScale
            e.number?.yScale = elementScale

            elements.append(e)
            addChild(e.shape!)
            addChild(e.number!)
        }
        }
        
        pointLabel.position.x = CGFloat(CGFloat(0) * 150.0 * elementScale + sceneWidthCenter)
        pointLabel.position.y = CGFloat(CGFloat(-4) * 150.0 * elementScale + sceneHeightCenter)
        addChild(pointLabel)
        timeLabel.position.x = CGFloat(CGFloat(0) * 150.0 * elementScale + sceneWidthCenter)
        timeLabel.position.y = CGFloat(CGFloat(-4.5) * 150.0 * elementScale + sceneHeightCenter)
        addChild(timeLabel)
        
        specialSpriteShape = SKSpriteNode(texture: getShape(num: -1))
        specialSpriteShape?.position.x = CGFloat(CGFloat(0) * 150.0 * elementScale + sceneWidthCenter)
        specialSpriteShape?.position.y = CGFloat(CGFloat(-5) * 150.0 * elementScale + sceneHeightCenter)
        specialSpriteShape?.zPosition = 1
        specialSpriteShape?.xScale = elementScale
        specialSpriteShape?.yScale = elementScale
        addChild(specialSpriteShape!)
        
        specialSpriteNumber = SKSpriteNode(texture: getNumber(num: -1))
        specialSpriteNumber?.position.x = CGFloat(CGFloat(0) * 150.0 * elementScale + sceneWidthCenter)
        specialSpriteNumber?.position.y = CGFloat(CGFloat(-5) * 150.0 * elementScale + sceneHeightCenter)
        specialSpriteNumber?.zPosition = 2
        specialSpriteNumber?.xScale = elementScale
        specialSpriteNumber?.yScale = elementScale
        specialSpriteNumber?.colorBlendFactor = 0.0
        specialSpriteNumber?.color = UIColor.black
        addChild(specialSpriteNumber!)

        dragonLeft.xScale = elementScale * 0.4 * 0.606
        dragonLeft.yScale = elementScale * 0.4 * 0.606
        dragonRight.xScale = elementScale * 0.4 * 0.606
        dragonRight.yScale = elementScale * 0.4 * 0.606
        dragonLeft.position.x = view.frame.size.width / 100 * 68
        dragonRight.position.x = view.frame.size.width / 100 * 32
        dragonLeft.position.y =  view.frame.size.height / 100 * 77
        dragonRight.position.y = view.frame.size.height / 100 * 77
        dragonLeft.zPosition = 3
        dragonRight.zPosition = 4
        addChild(dragonLeft)
        addChild(dragonRight)
        
        
        gameFinish.position.y = view.frame.height / 2
        gameFinish.position.x = view.frame.width / 2
        gameFinish.xScale = 0.4
        gameFinish.yScale = 0.4
        gameFinish.zPosition = 5
        gameFinish.isHidden = true
        addChild(gameFinish)

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        line!.position = pos
 
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        for e in elements {
            if e.shape!.position.x < pos.x + 30 &&
                 e.shape!.position.x > pos.x - 30 &&
             e.shape!.position.y < pos.y + 30 &&
                e.shape!.position.y > pos.y - 30 {
                e.shape?.xScale = 0.25
                e.shape?.yScale = 0.25
                e.number?.xScale = 0.25
                e.number?.yScale = 0.25
                e.select = true
                
                
                        do {
                            select = try AVAudioPlayer(contentsOf: selectSoundURL!)
                //            player?.numberOfLoops = -1   // ループ再生する
                            select?.prepareToPlay()      // 即時再生させる
                            select?.play()               // BGMを鳴らす
                        } catch {
                            print("error...")
                        }

            }
        }
//        points[1] = pos
//        line?.atPoint(points[1])
        //line?.run(SKAction.move(to: pos, duration: 0.01) )
      //  line?.run(SKAction.moveTo(x: pos.x, duration: 0.1) )
//        line?.run(SKAction.scaleX(to: pos.x , duration: 0.1) )
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        var c: Int = -1
        var s: Int = -1
        var n: Int = -1
        var count1c: Int = 0
        var count1s: Int = 0
        var count1n: Int = 0
        for e in elements {
            if e.select {
                if c != -1 {
                    if c == e.colorNumber {
                        count1c += 1
                    } else {
                        count1c = -1
                        break
                    }
                }
                c = e.colorNumber!
                
                if s != -1 {
                    if s == e.shapeNumber {
                        count1s += 1
                    } else {
                        count1s = -1
                        break
                    }
                }
                s = e.shapeNumber!

                if n != -1 {
                    if n == e.numberNumber {
                        count1n += 1
                    } else {
                        count1n = -1
                        break
                    }
                }
                n = e.numberNumber!
            }
        }

        if count1c > 0 {
            if count1c == count1s &&
                count1c == count1n {
                if count1c >= specialSize {

                    specialColor  = getColor(num: c)
                    specialShape  = getShape(num: s)
                    specialNumber = getNumber(num: n)
                    specialSpriteShape?.texture = specialShape
                    specialSpriteNumber?.texture = specialNumber
                    specialSpriteShape?.colorBlendFactor = 1.0
                    specialSpriteShape?.color = specialColor!
                    specialSpriteNumber?.colorBlendFactor = 1.0
                    specialSpriteNumber?.color = UIColor.black

                    specialSize = count1c
                    if count1c == 1 {
                        specialSpriteShape?.xScale = elementScale * 0.5
                        specialSpriteShape?.yScale = elementScale * 0.5
                        specialSpriteNumber?.xScale = elementScale * 0.5
                        specialSpriteNumber?.yScale = elementScale * 0.5
                    } else if count1c == 2 {
                        specialSpriteShape?.xScale = elementScale
                        specialSpriteShape?.yScale = elementScale
                        specialSpriteNumber?.xScale = elementScale
                        specialSpriteNumber?.yScale = elementScale
                    } else if count1c == 3 {
                        specialSpriteShape?.xScale = elementScale * 2.0
                        specialSpriteShape?.yScale = elementScale * 2.0
                        specialSpriteNumber?.xScale = elementScale * 2.0
                        specialSpriteNumber?.yScale = elementScale * 2.0
                    } else {
                        specialSpriteShape?.xScale = elementScale * 3.0
                        specialSpriteShape?.yScale = elementScale * 3.0
                        specialSpriteNumber?.xScale = elementScale * 3.0
                        specialSpriteNumber?.yScale = elementScale * 3.0
                    }
                }
            }
        }
        
        
        
        var i: Int = -1
        var count1: Int = 0
        for e in elements {
            if e.select {
                if i != -1 {
                    if i == e.colorNumber {
                        e.delete = true
                        e.deleteY = e.shape?.position.y
                        count1 += 1
                    } else {
                        count1 = -1
                        break
                    }
                }
                i = e.colorNumber!
            }
        }

        if count1 >= 1 {
            for e in elements {
                if e.select {
                    if i == e.colorNumber{
                        e.delete = true
                        e.deleteY = e.shape?.position.y
                        break
                    }
                }
            }
        
            for e in elements {
                if e.delete {
                    initElement(e: e)
                }
            }
        }
        if count1 > 0 {
            addPoint(p: count1)
        }
///////////////////////////////////////////
        i = -1
        var count2 = 0
        for e in elements {
            if e.select {
                if i != -1 {
                    if i == e.numberNumber {
                        e.delete = true
                        e.deleteY = e.shape?.position.y
                        count2 += 1
                    } else {
                        count2 = -1
                        break
                    }
                }
                i = e.numberNumber!
            }
        }

        if count2 >= 1 {
            for e in elements {
                if e.select {
                    if i == e.numberNumber{
                        e.delete = true
                        e.deleteY = e.shape?.position.y
                        break
                    }
                }
            }
        
            for e in elements {
                if e.delete {
                    initElement(e: e)
                }
            }
        }
        if count2 > 0 {
            addPoint(p: count2)
        }
//////////////////////////////////////////
        i = -1
        var count3 = 0
        for e in elements {
            if e.select {
                if i != -1 {
                    if i == e.shapeNumber {
                        e.delete = true
                        e.deleteY = e.shape?.position.y
                        count3 += 1
                    } else {
                        count3 = -1
                        break
                    }
                }
                i = e.shapeNumber!
            }
        }

        if count3 >= 1 {
            for e in elements {
                if e.select {
                    if i == e.shapeNumber{
                        e.delete = true
                        e.deleteY = e.shape?.position.y
                        break
                    }
                }
            }
        
            for e in elements {
                if e.delete {
                    initElement(e: e)
                }
            }
        }
        if count3 > 0 {
            addPoint(p: count3)
        }
//////////////////////////////////////////

        pointLabel.text = "point:" + point.description
        
        for e in elements {
            if e.select {
                initScaleSelectElement(e: e)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
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
    
    
    var frameTime: Int = 0
    override func update(_ currentTime: TimeInterval) {
        if mode == Mode.free {
            backgroundColor = UIColor.gray
        }
        if mode == Mode.timeAttack {
            backgroundColor = UIColor.gray
            
            if time > 10 {
                gameFinish.isHidden = false
            }
            if time > 11 {
                let scene = ResultScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                scene.setPoint(point: point)
                self.view!.presentScene(scene)

            }
        }
        if mode == Mode.collectBadge {
            backgroundColor = UIColor.green
        }
        frameTime += 1
        if frameTime >= 100 {
            frameTime = 0
            time += 1
        }
        timeLabel.text = "time:" + time.description

        for e in elements {
            if e.number!.position.y > (sceneHeightCenter - 450.0 * elementScale) {
                var fallFlag = true
                for e2 in elements {
                    if e !== e2 &&
                        e.number?.position.x == e2.number?.position.x &&
                        e.number!.position.y < (e2.number!.position.y + 150.0 * elementScale) &&
                        e.number!.position.y > (e2.number!.position.y){
                        fallFlag = false
                    }
                }
                

                if fallFlag {
                    e.number?.position.y -= 4
                    e.shape?.position.y -= 4
                }
            
            }
        }
    }
}
