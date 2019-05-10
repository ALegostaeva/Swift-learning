//
//  GameScene.swift
//  Space Race
//
//  Created by Александра Легостаева on 10/05/2019.
//  Copyright © 2019 self. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var field : SKEmitterNode!
    private var player : SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let possibleEnemies = ["ball", "hammer", "tv"]
    var isGameOver = false
    var gameTimer: Timer?
    
    override func didMove(to view: SKView) {
        
        
        startGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.y < -150 {
                node.removeFromParent()
                score += 1
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > frame.midY {
            location.y = frame.midY
        }
        
        player.position = location
    }
  
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        player.position = location
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explision = SKEmitterNode(fileNamed: "explosion")!
        explision.position = player.position
        addChild(explision)
        
        gameOver()
    }
    
    private func startGame() {
        backgroundColor = .black
        
        isGameOver = false
        
        field = SKEmitterNode(fileNamed: "Starfield")!
        field.position = CGPoint(x: frame.midX, y: frame.maxY)
        field.advanceSimulationTime(10)
        addChild(field)
        field.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: frame.midX, y: frame.midY/3)
        player.zRotation = 1.6
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 100, y: 30)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
 
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    @objc private func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: CGFloat.random(in: 0.0...700.0), y: frame.maxY)
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        
    }
    
    func gameOver() {
        player.removeFromParent()
        field.removeFromParent()
        
        isGameOver = true
        
        UserDefaults.standard.set(score, forKey: "RecentScore")
        
        if score > UserDefaults.standard.integer(forKey: "HighScore") {
            UserDefaults.standard.set(score, forKey: "HighScore")
        }
        
        let menuScene = Menu(size: view!.bounds.size)
        view?.presentScene(menuScene)
    }

}
