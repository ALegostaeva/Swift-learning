//
//  Menu.swift
//  Space Race
//
//  Created by Александра Легостаева on 10/05/2019.
//  Copyright © 2019 self. All rights reserved.
//

import SpriteKit

class Menu: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        addBackground()
        addLogo()
        addLabels()
        
    }
    
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "player")
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.midY/2)
        debugPrint(logo)
        addChild(logo)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 1)
        logo.run(SKAction.repeatForever(spin))
    }
    
    func addLabels() {
        
        let playLabel = SKLabelNode(text: "Tap to play")
        playLabel.fontName = "Chalkduster"
        playLabel.fontSize = 50
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        
        let highScoreLabel = SKLabelNode(text: "Highscore: \(UserDefaults.standard.integer(forKey: "HighScore"))")
        highScoreLabel.fontName = "Chalkduster"
        highScoreLabel.fontSize = 30
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*4)
        addChild(highScoreLabel)
        
        let recentScoreLabel = SKLabelNode(text: "Recent score: \(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentScoreLabel.fontName = "Chalkduster"
        recentScoreLabel.fontSize = 30
        recentScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.frame.midY - highScoreLabel.frame.size.height*2)
        addChild(recentScoreLabel)
    }
    
    func addBackground() {
        let field = SKEmitterNode(fileNamed: "Starfield")!
        field.position = CGPoint(x: frame.midX, y: frame.maxY)
        field.advanceSimulationTime(10)
        addChild(field)
        field.zPosition = -1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
    
}
