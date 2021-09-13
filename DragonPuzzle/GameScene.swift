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
    var levelNumber: Int = 2
    var dragonNumber: Int = 0
    var background: SKSpriteNode = SKSpriteNode(imageNamed: "background")
    var face: SKSpriteNode = SKSpriteNode(imageNamed: "face")
    var whiteEyeLeft: SKSpriteNode = SKSpriteNode(imageNamed: "white_eye")
    var whiteEyeRight: SKSpriteNode = SKSpriteNode(imageNamed: "white_eye")
    var blackEyeLeft: SKSpriteNode = SKSpriteNode(imageNamed: "black_eye")
    var blackEyeRight: SKSpriteNode = SKSpriteNode(imageNamed: "black_eye")
    var nose: SKSpriteNode = SKSpriteNode(imageNamed: "nose")

    var home: SKSpriteNode = SKSpriteNode(imageNamed: "home")
    var watch: SKSpriteNode = SKSpriteNode(imageNamed: "watch")
    var lifeFrame: SKSpriteNode = SKSpriteNode(imageNamed: "life_frame")
    var life: SKSpriteNode = SKSpriteNode(imageNamed: "life")

    
    
    var backgroundX: CGFloat = 0.0
    var backgroundY: CGFloat = 0.0
    var faceX: CGFloat = 0.0
    var faceY: CGFloat = 0.0
    var faceVerticalSpeed: CGFloat = 2.0
    var faceHorizonSpeed: CGFloat = 2.0
    var leftEyeVerticalSpeed: CGFloat = 0.9
    var rightEyeVerticalSpeed: CGFloat = 0.7
    var leftEyeHorizonSpeed: CGFloat = 1.3
    var rightEyeHorizonSpeed: CGFloat = 1.7
    var eyeHeight: CGFloat = 0.0
    var leftEyeX: CGFloat = 0.0
    var rightEyeX: CGFloat = 0.0
//    var dragonLeft: SKSpriteNode = SKSpriteNode(imageNamed: "dragonLeft")
//    var dragonRight: [SKSpriteNode] = [
//        SKSpriteNode(imageNamed: "dragonRight"),
//        SKSpriteNode(imageNamed: "dragon2"),
//        SKSpriteNode(imageNamed: "dragon3"),
//        SKSpriteNode(imageNamed: "dragon4"),
//        SKSpriteNode(imageNamed: "dragon5")
//    ]
//    var dragonWhite: SKSpriteNode = SKSpriteNode(imageNamed: "quad")
    let DRAGON_LIFE: Int = 10
    var dragonLife: Int?
    var dragonNum: Int = 0
    var dragonScale: CGFloat = 1.0

    var elements : [Element] = []
    var elementScale : CGFloat = 0.5
    var sceneHeightCenter : CGFloat = 300.0
    var sceneWidthCenter : CGFloat = 300.0
    
    var gameFinish: SKSpriteNode = SKSpriteNode(imageNamed: "gamefinish")

    var lifeLabel : SKLabelNode = SKLabelNode(text: "1800/1800")
//    var pointLabel : SKLabelNode = SKLabelNode(text: "point")
    var point : Int64 = 0
    var timeLabel : SKLabelNode = SKLabelNode(text: "0/60")
    var time : Int64 = 0
    var timeLimit : Int64 = 0
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
    func setStageLevelTime(stage: Int, level: Int, time: Int64) {
        print(stage)
        dragonNumber = stage
        print(level)
        levelNumber = level
        print(time)
        timeLimit = time
    }
    func getColor(num: Int) -> UIColor {
        if      num == 0 { return UIColor.red }
        else if num == 1 { return UIColor.green }
        else if num == 2 { return UIColor.white }
        else if num == 3 { return UIColor.yellow }
        else             { return UIColor.cyan }
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
        else if num == 3 { return SKTexture(imageNamed: "hexagon") }
        else             { return SKTexture(imageNamed: "star") }
    }
    func initElement(e: Element) {
        e.colorNumber = Int.random(in: 0...levelNumber)
        e.numberNumber = Int.random(in: 0...levelNumber)
        e.shapeNumber = Int.random(in: 0...levelNumber)
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
        e.shape?.position.y = CGFloat( elementScale * 1500)
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
        dragonLife! -= p
        if dragonLife! <= 0 {
            dragonLife! = 0
        }
        print("life:" + dragonLife!.description)
        let scale: CGFloat = dragonScale * CGFloat(dragonLife!) / 10.0
        print(scale)
//        dragonRight[dragonNumber].xScale = scale
//        dragonRight[dragonNumber].yScale = scale
//        if dragonLife! <= 0 {
//            dragonNum += 1
//            dragonLife = DRAGON_LIFE
//            dragonRight[dragonNumber].position.y = sceneHeightCenter * 2
//            dragonRight[dragonNumber].xScale = dragonScale
//            dragonRight[dragonNumber].yScale = dragonScale
//            dragonRight[dragonNumber].zPosition = 10
//        }
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
        background.zPosition = -1
        home.zPosition = 996
        watch.zPosition = 996
        timeLabel.zPosition = 996
        lifeLabel.zPosition = 996
        face.zPosition = 995
        life.zPosition = 994
        lifeFrame.zPosition = 993
        whiteEyeLeft.zPosition = 996
        whiteEyeRight.zPosition = 996
        blackEyeLeft.zPosition = 997
        blackEyeRight.zPosition = 997
        nose.zPosition = 997

        background.position.x += view.bounds.width / 2
        background.position.y += view.bounds.height / 2
        face.position.x += view.bounds.width / 2
        face.position.y += view.bounds.height / 10 * 8
        whiteEyeLeft.position.x += view.bounds.width / 2 - 55
        whiteEyeRight.position.x += view.bounds.width / 2 + 55
        whiteEyeLeft.position.y += view.bounds.height / 10 * 8
        whiteEyeRight.position.y += view.bounds.height / 10 * 8
        blackEyeLeft.position.x += view.bounds.width / 2 - 55
        blackEyeRight.position.x += view.bounds.width / 2 + 55
        blackEyeLeft.position.y += view.bounds.height / 10 * 8
        blackEyeRight.position.y += view.bounds.height / 10 * 8
        nose.position.x += view.bounds.width / 2
        nose.position.y += view.bounds.height / 60 * 43
        backgroundX = view.bounds.width / 2
        backgroundY = view.bounds.height / 2
        faceX = view.bounds.width / 2
        faceY = view.bounds.height / 10 * 8
        eyeHeight = view.bounds.height / 10 * 8
        leftEyeX = view.bounds.width / 2 - 55
        rightEyeX = view.bounds.width / 2 + 55
        
        home.position.x += view.bounds.width / 10
        home.position.y += view.bounds.height / 10 * 9
        watch.position.x += view.bounds.width / 10 * 8
        watch.position.y += view.bounds.height / 10 * 9
        lifeFrame.position.x += view.bounds.width / 2
        lifeFrame.position.y += view.bounds.height / 100 * 66
        life.position.x += view.bounds.width / 2
        life.position.y += view.bounds.height / 100 * 66
        lifeLabel.position.x += view.bounds.width / 10 * 8
        lifeLabel.position.y += view.bounds.height / 100 * 67
        lifeLabel.fontName = "Arial Bold"
        lifeLabel.fontSize = 26
        lifeLabel.fontColor = .red

        addChild(background)
        addChild(face)
        addChild(whiteEyeLeft)
        addChild(whiteEyeRight)
        addChild(blackEyeLeft)
        addChild(blackEyeRight)
        addChild(nose)
        addChild(home)
        addChild(watch)
        addChild(lifeFrame)
        addChild(life)
        addChild(lifeLabel)

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
        sceneHeightCenter = view.frame.size.height / 3.0
        sceneWidthCenter = view.frame.size.width / 2.0
        for y in -3...4 {
        for x in -2...3 {
            let e = Element()
            
            e.colorNumber = Int.random(in: 0...levelNumber)
            e.numberNumber = Int.random(in: 0...levelNumber)
            e.shapeNumber = Int.random(in: 0...levelNumber)
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
            e.x                  = CGFloat(CGFloat(x) * 150.0 * elementScale + sceneWidthCenter - 75.0 * elementScale)
            e.number?.position.x = CGFloat(CGFloat(x) * 150.0 * elementScale + sceneWidthCenter - 75.0 * elementScale)
            e.number?.position.y = CGFloat(CGFloat(y) * 150.0 * elementScale + sceneHeightCenter)
            e.shape?.position.x =  CGFloat(CGFloat(x) * 150.0 * elementScale + sceneWidthCenter - 75.0 * elementScale)
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
        
//        pointLabel.position.x = CGFloat(CGFloat(0) * 150.0 * elementScale + sceneWidthCenter)
//        pointLabel.position.y = CGFloat(CGFloat(-4) * 150.0 * elementScale + sceneHeightCenter)
//        addChild(pointLabel)
        timeLabel.fontName = "Arial Bold"
        timeLabel.fontSize = 26
        timeLabel.position.x += view.bounds.width / 10 * 8 + 46
        timeLabel.position.y += view.bounds.height / 10 * 9 - 10
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

//        dragonScale = elementScale * 0.4 * 0.606
//        dragonLeft.xScale = elementScale * 0.4 * 0.606
//        dragonLeft.yScale = elementScale * 0.4 * 0.606
//        dragonRight[dragonNumber].xScale = elementScale * 0.4 * 0.606
//        dragonRight[dragonNumber].yScale = elementScale * 0.4 * 0.606
//        dragonLeft.position.x = view.frame.size.width / 100 * 68
//        dragonRight[dragonNumber].position.x = view.frame.size.width / 100 * 32
//        dragonLeft.position.y =  view.frame.size.height / 100 * 77
//        dragonRight[dragonNumber].position.y = view.frame.size.height / 100 * 77
//        dragonLeft.zPosition = 6
//        dragonRight[dragonNumber].zPosition = 7
//        addChild(dragonLeft)
//        addChild(dragonRight[dragonNumber])
//
//        dragonWhite.xScale = elementScale * 3.34
//        dragonWhite.yScale = elementScale * 3.34
//        dragonWhite.position.x = view.frame.size.width / 100 * 32
//        dragonWhite.position.y = view.frame.size.height / 100 * 77
//        dragonWhite.zPosition = 5
//        addChild(dragonWhite)
        
        gameFinish.position.y = view.frame.height / 2
        gameFinish.position.x = view.frame.width / 2
        gameFinish.xScale = 0.4
        gameFinish.yScale = 0.4
        gameFinish.zPosition = 5
        gameFinish.isHidden = true
        addChild(gameFinish)

        dragonLife = DRAGON_LIFE
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
        if pos.y < CGFloat(elementScale * 1310) {
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
    
    var atackTime = 0
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
            atackTime = count1
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
            atackTime = count2
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
            atackTime = count3
        }
//////////////////////////////////////////

//        pointLabel.text = "point:" + point.description
        
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
    
    var gameClearWaitTime = 0
    var frameTime: Int = 0
    var animationTime: Int = 61
    override func update(_ currentTime: TimeInterval) {
        if mode == Mode.free {
            backgroundColor = UIColor.black
        }
        if mode == Mode.timeAttack {
            backgroundColor = UIColor.black
            
            if time > timeLimit {
                gameFinish.isHidden = false
            }
            if time > (timeLimit + 1) {
                let scene = ResultScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                scene.setPoint(point: point)
                scene.setDragon(dragonNum: dragonNum)
                self.view!.presentScene(scene)

            }
        }
        if mode == Mode.collectBadge {
            backgroundColor = UIColor.black
        }
        frameTime += 1
        animationTime += 1
        if frameTime >= 50 {
            if !gameFinish.isHidden && gameClearWaitTime > 49 {
                let scene = ResultScene(size: self.scene!.size)
                scene.scaleMode = .aspectFill
                scene.setPoint(point: point)
                scene.setDragon(dragonNum: dragonNum)
                self.view!.presentScene(scene)
            }
            frameTime = 0
            time += 1
        }
        timeLabel.text = time.description + "/60"

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
                    if frameTime > 11 {
                        animationTime = 0
//                        atackTime = 0
                    }
                    e.number?.position.y -= 4
                    e.shape?.position.y -= 4
                }
            
            }
        }
        
        if animationTime < 30 * atackTime {

            if blackEyeRight.position.x - whiteEyeRight.position.x > 20 ||  blackEyeRight.position.x - whiteEyeRight.position.x < -20 {
                rightEyeHorizonSpeed *= -1
            }
            if blackEyeLeft.position.x - whiteEyeLeft.position.x > 20 ||  blackEyeLeft.position.x - whiteEyeLeft.position.x < -20 {
                leftEyeHorizonSpeed *= -1
            }
            blackEyeLeft.position.x += leftEyeHorizonSpeed + faceHorizonSpeed
            blackEyeRight.position.x += rightEyeHorizonSpeed + faceHorizonSpeed

            if blackEyeRight.position.y > eyeHeight + 20 ||  blackEyeRight.position.y < eyeHeight - 20 {
                rightEyeVerticalSpeed *= -1
            }
            if blackEyeLeft.position.y > eyeHeight + 20 ||  blackEyeLeft.position.y < eyeHeight - 20 {
                leftEyeVerticalSpeed *= -1
            }
            blackEyeLeft.position.y += leftEyeVerticalSpeed
            blackEyeRight.position.y += rightEyeVerticalSpeed

            if face.position.x > faceX + 10 || face.position.x < faceX - 10 {
                faceHorizonSpeed *= -1
            }
            if face.position.y > faceY + 20 || face.position.y < faceY - 20 {
                faceVerticalSpeed *= -1
            }
            face.position.x += faceHorizonSpeed
            face.position.y += faceVerticalSpeed
            whiteEyeLeft.position.x += faceHorizonSpeed
            whiteEyeRight.position.x += faceHorizonSpeed
            whiteEyeLeft.position.y += faceVerticalSpeed
            whiteEyeRight.position.y += faceVerticalSpeed
            nose.position.x += faceHorizonSpeed
            nose.position.y += faceVerticalSpeed


            life.xScale -= 1.0 / 1800.0
            face.colorBlendFactor = 1.0
            face.color = UIColor.init(red: 1.0, green: 1.0, blue: 0.0, alpha: life.xScale)

            if life.xScale <= 0.0 {
                life.xScale = 0.0
                life.isHidden = true
                gameFinish.isHidden = false
                gameClearWaitTime += 1
            }
            lifeLabel.text = Int(life.xScale * 1800).description + "/1800"
            background.position.x += CGFloat.random(in: -20...20)
            background.position.y += CGFloat.random(in: -20...20)

        } else {
            blackEyeLeft.position.x = whiteEyeLeft.position.x
            blackEyeRight.position.x = whiteEyeRight.position.x
            blackEyeLeft.position.y = whiteEyeLeft.position.y
            blackEyeRight.position.y = whiteEyeRight.position.y

            background.position.x = backgroundX
            background.position.y = backgroundY
        }
    }
}
