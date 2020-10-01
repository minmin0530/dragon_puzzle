//
//  StageScene.swift
//  DragonPuzzle
//
//  Created by Yoshiki Izumi on 2020/08/14.
//  Copyright © 2020 Yoshiki Izumi. All rights reserved.
//

import SpriteKit
import GameplayKit

class StageScene : SKScene,UITableViewDelegate,UITableViewDataSource {
    var tableView: UITableView = UITableView()
    var stageArray: [String] = []
//    var collectBadgeButton : SKLabelNode = SKLabelNode(text: "Collect Badge")
//    var timeAttackButton : SKLabelNode = SKLabelNode(text: "Time Attack")
//    var freeModeButton : SKLabelNode = SKLabelNode(text: "Free Mode")
//    var rankingButton : SKLabelNode = SKLabelNode(text: "Ranking")

    override func didMove(to view: SKView) {
        for time in 1...3 {
            for level in 1...3 {
                for stage in 1...5 {
                    stageArray.append("stage" + stage.description + "  level" + level.description + "  time" + time.description + "minutes")
                }
            }
        }
//        collectBadgeButton.position.x = view.frame.width / 2
//        collectBadgeButton.position.y = view.frame.height / 10 * 7
//        collectBadgeButton.name = "collectionBadgeButton"
//        addChild(collectBadgeButton)
//        timeAttackButton.position.x = view.frame.width / 2
//        timeAttackButton.position.y = view.frame.height / 10 * 6
//        timeAttackButton.name = "timeAttackButton"
//        addChild(timeAttackButton)
//        freeModeButton.position.x = view.frame.width / 2
//        freeModeButton.position.y = view.frame.height / 10 * 5
//        freeModeButton.name = "freeModeButton"
//        addChild(freeModeButton)
//        rankingButton.position.x = view.frame.width / 2
//        rankingButton.position.y = view.frame.height / 10 * 4
//        rankingButton.name = "rankingButton"
//        addChild(rankingButton)

        //テーブルビューの設置場所を指定

               tableView.frame = CGRect(x:view.frame.width * 0/100, y:view.frame.height * 10/100,

                                        width:view.frame.width * 100/100, height:view.frame.height * 80/100)

               // sampleTableView の dataSource 問い合わせ先を self に

               tableView.delegate = self

               // sampleTableView の delegate 問い合わせ先を self に

               tableView.dataSource = self

               //cellに名前を付ける

               tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

               //実際にviewにsampleTableViewを表示させる

        self.view!.addSubview(tableView)

               //cellの高さを指定

               self.tableView.rowHeight = 100

               //セパレーターの色を指定

               tableView.separatorColor = UIColor.blue

        
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first as UITouch? {
//            let location = touch.location(in:self)
//            if self.atPoint(location).name == "freeModeButton" {
//                let scene = GameScene(size: self.scene!.size)
//                scene.scaleMode = .aspectFill
//                scene.setMode(m: Mode.free)
//                self.view!.presentScene(scene)
//            }
//
//            if self.atPoint(location).name == "timeAttackButton" {
//                let scene = GameScene(size: self.scene!.size)
//                scene.scaleMode = .aspectFill
//                scene.setMode(m: Mode.timeAttack)
//                self.view!.presentScene(scene)
//            }
//
//            if self.atPoint(location).name == "collectionBadgeButton" {
//                let scene = GameScene(size: self.scene!.size)
//                scene.scaleMode = .aspectFill
//                scene.setMode(m: Mode.collectBadge)
//                self.view!.presentScene(scene)
//            }
//
//            if self.atPoint(location).name == "rankingButton" {
//                let scene = RankingScene(size: self.scene!.size)
//                scene.scaleMode = .aspectFill
//                self.view!.presentScene(scene)
//            }
//
//        }
//    }
    
    
      func tableView(_ sampleTableView: UITableView, numberOfRowsInSection section: Int) -> Int {

           //

           return stageArray.count

       }

       //cellのコンテンツ

       func tableView(_ sampleTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")

           //cellにはsampleArrayが一つずつ入るようにするよ！

           cell.textLabel?.text = stageArray[indexPath.row]

    

           return cell

       }

       

       //cellが選択された時の処理

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番セルが押されたよ！")
        tableView.removeFromSuperview()
        tableView.delegate = nil
        tableView.dataSource = nil
        let scene = GameScene(size: self.scene!.size)
        scene.scaleMode = .aspectFill
        scene.setMode(m: Mode.timeAttack)
        scene.setStageLevelTime(
            stage: indexPath.row % 15 % 5,
            level: (indexPath.row % 15 / 5) + 2,
            time : Int64((indexPath.row / 15) + 1) * 30 )
        self.view!.presentScene(scene)
    }

       

       //削除機能をち追加してみましょう！

//       func tableView(_ sampleTableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//
//
//           let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
//
//               self.stageArray.remove(at: indexPath.row)
//
//               sampleTableView.deleteRows(at: [indexPath], with: .fade)
//
//           }
//
//           deleteButton.backgroundColor = UIColor.red
//
//
//
//           return [deleteButton]
//
//       }
}
