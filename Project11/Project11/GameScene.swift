//
//  GameScene.swift
//  Project11
//
//  Created by Александра Легостаева on 25/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var refreshLabel: SKLabelNode!
    
    var ballsCountLabel: SKLabelNode!
    var ballsCount = 5 {
        didSet {
            ballsCountLabel.text = "Balls: \(ballsCount)"
        }
    }
    
    var startNewGameLabel: SKLabelNode!
    
    var gameIsOver = false
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        for index in 0...4 {
            let xPosition = index * 256
            let bouncer = SKSpriteNode(imageNamed: "bouncer")
            bouncer.position = CGPoint(x: xPosition, y: 0)
            bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
            bouncer.physicsBody?.isDynamic = false
            addChild(bouncer)
        }
        
        for index in [1,3,5,7] {
            let xPosition = 128 * index
            let quality = (index == 3) || (index == 7)
            makeSlot(at: CGPoint(x: xPosition, y: 0), isGood: quality)
        }
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        refreshLabel = SKLabelNode(fontNamed: "Chalkduster")
        refreshLabel.text = "Restart"
        refreshLabel.position = CGPoint(x: 500, y: 700)
        addChild(refreshLabel)
        
        ballsCountLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsCountLabel.text = "Balls: 5"
        ballsCountLabel.horizontalAlignmentMode = .right
        ballsCountLabel.position = CGPoint(x: 980, y: 650)
        addChild(ballsCountLabel)
        
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let objects = nodes(at: location)
            if gameIsOver {

                    restartGame()
                
            } else {
                
                if objects.contains(editLabel) {
                    editingMode.toggle()
                } else {
                    if editingMode {
                        
                        if location.y >= 200 && location.y <= 700 {
                            let size = CGSize(width: Int.random(in: 16...128), height: 16)
                            let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                            box.zRotation = CGFloat.random(in: 0...3)
                            box.position = location
                            
                            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                            box.physicsBody?.isDynamic = false
                            
                            addChild(box)
                        }
                        
                    } else {
                        
                        if location.y >= 300 && location.y <= 700 {
                            let balls = ["ballRed", "ballGreen", "ballYellow", "ballCyan", "ballGrey", "ballPurple", "ballBlue"]
                            
                            let ball = SKSpriteNode(imageNamed: balls.randomElement()!)
                            
                            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                            ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                            ball.physicsBody?.restitution = 0.4
                            ball.position = location
                            ball.name = "ball"
                            addChild(ball)
                        } else {
                            if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
                                fireParticles.position = location
                                addChild(fireParticles)
                            }
                        }
                        
                    }
                }
                
                if objects.contains(refreshLabel) {
                    debugPrint("tapped refresh")
                    restartGame()
                }
            }
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            ballsCount += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            ballsCount -= 1
            if ballsCount == 0 {
                gameIsOver = true
                removeAllChildren()
                
                let bgGameOver = SKSpriteNode(imageNamed: "background.jpg")
                bgGameOver.position = CGPoint(x: 512, y: 384)
                bgGameOver.blendMode = .replace
                bgGameOver.zPosition = -2
                addChild(bgGameOver)
                
                let gameOver = SKLabelNode(fontNamed: "Chalkduster")
                gameOver.text = "Game over!"
                gameOver.color = .gray
                gameOver.fontSize = 50
                gameOver.position = CGPoint(x: 512, y: 384)
                gameOver.zPosition = -1
                addChild(gameOver)
                
                let startNewGameLabel = SKLabelNode(fontNamed: "Chalkduster")
                startNewGameLabel.text = "Start new game"
                startNewGameLabel.color = .white
                startNewGameLabel.position = CGPoint(x: 512, y: 200)
                addChild(startNewGameLabel)
            }
        }
    }
    
    func destroy(ball: SKNode) {
        
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    
    @objc func restartGame() {
        gameIsOver = false
        debugPrint("resrtar game func")
        removeAllChildren()
        let view = SKView()
        didMove(to: view)
    }
    
}
