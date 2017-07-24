//
//  GameScene.swift
//  PalaceCardGame
//
//  Created by iD Student on 7/24/17.
//  Copyright © 2017 iD Blair. All rights reserved.
//

import SpriteKit
import GameplayKit
struct GameState {
    static var PlayerTurn = 0
    static var ComputerTurn = 1
    static var GameOver = 2


}
class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var state = GameState.PlayerTurn
    var playerHandPile = [Card] ()
    var playerPile1 = [Card] () //these are the end piles
    var playerPile2 = [Card] ()
    var playerPile3 = [Card] () //
    var playedPile = [Card] ()
    var drawPile = [Card] ()
    var computerHandPile = [Card] ()
    var computerPile1 = [Card] () //these ae the end piles//
    var computerPile2 = [Card] ()
    var computerPile3 = [Card] () //
    
    

    override func didMove(to view: SKView) {
        distributeCardsRandomly()
        
        
    
        
    }
    

    func distributeCardsRandomly () {
        playerPile1.append(CardCollection.instance.pickRandomCard())
        playerPile2.append(CardCollection.instance.pickRandomCard())
        playerPile3.append(CardCollection.instance.pickRandomCard())
        playerPile1.append(CardCollection.instance.pickRandomCard())
        playerPile2.append(CardCollection.instance.pickRandomCard())
        playerPile3.append(CardCollection.instance.pickRandomCard())
        playerHandPile.append(CardCollection.instance.pickRandomCard())
        computerHandPile.append(CardCollection.instance.pickRandomCard())
        playerHandPile.append(CardCollection.instance.pickRandomCard())
        computerHandPile.append(CardCollection.instance.pickRandomCard())
        playerHandPile.append(CardCollection.instance.pickRandomCard())
        computerHandPile.append(CardCollection.instance.pickRandomCard())
        
        
        for _ in 0 ..< CardCollection.instance.cards.count  {
        drawPile.append(CardCollection.instance.pickRandomCard())
        }
        
    }
    func updateCardUI() {
        var playerUp1 = self.childNode(withName: "PlayerUp1") as! SKSpriteNode
        playerUp1.texture = SKTexture (imageNamed: "/(card)")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
