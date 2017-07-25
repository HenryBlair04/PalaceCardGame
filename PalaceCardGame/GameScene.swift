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
    var playerPile3 = [Card] ()
    var playerPile4 = [Card] ()// up 1
    var playerPile5 = [Card] ()// up 2
    var playerPile6 = [Card] () // up 3
    
    
    var playedPile = [Card] ()
    var drawPile = [Card] ()
    var computerHandPile = [Card] ()
    var computerPile1 = [Card] () //these are the down end piles//
    var computerPile2 = [Card] ()
    var computerPile3 = [Card] ()
    var computerPile4 = [Card] () //up 1
    var computerPile5 = [Card] () // up 2
    var computerPile6 = [Card] () //up 3
    
    
    //these are fake cards that are place holders,sheilding the cards in the back. when those back cards are played with an if state,ent these will dissappear
    var fakeCardBack1 = [Card] ()
    var fakeCardBack2 = [Card] ()
    var fakeCardBack3 = [Card] ()
    var fakeCardBack4 = [Card] ()
    var fakeCardBack5 = [Card] ()
    var fakeCardBack6 = [Card] ()
    
    
    override func didMove(to view: SKView) {
        distributeCardsRandomly()
        updateCardUI()
        
        
        
        
    }
    
    
    func distributeCardsRandomly () {
        playerPile1.append(CardCollection.instance.pickRandomCard())
        computerPile1.append(CardCollection.instance.pickRandomCard())
        playerPile2.append(CardCollection.instance.pickRandomCard())
        computerPile2.append(CardCollection.instance.pickRandomCard())
        playerPile3.append(CardCollection.instance.pickRandomCard())
        computerPile3.append(CardCollection.instance.pickRandomCard())
        playerPile4.append(CardCollection.instance.pickRandomCard())
        computerPile4.append(CardCollection.instance.pickRandomCard())
        playerPile5.append(CardCollection.instance.pickRandomCard())
        computerPile5.append(CardCollection.instance.pickRandomCard())
        playerPile6.append(CardCollection.instance.pickRandomCard())
        computerPile6.append(CardCollection.instance.pickRandomCard())
        playerHandPile.append(CardCollection.instance.pickRandomCard())
        computerHandPile.append(CardCollection.instance.pickRandomCard())
        playerHandPile.append(CardCollection.instance.pickRandomCard())
        computerHandPile.append(CardCollection.instance.pickRandomCard())
        playerHandPile.append(CardCollection.instance.pickRandomCard())
        computerHandPile.append(CardCollection.instance.pickRandomCard())
        
        
        for i in 0 ..< CardCollection.instance.cards.count  {
            drawPile.append(CardCollection.instance.pickRandomCard())
        print (i)
        }
        
    }
    func updateCardUI() {
        let playerDown1 = self.childNode(withName: "PlayerDown1") as! SKSpriteNode
        if let ppd1Value = playerPile1.last?.value, let ppd1Suit = playerPile1.last?.suit {
            playerDown1.texture = SKTexture (imageNamed: "\(ppd1Value) \(ppd1Suit)")
        }
        
        let computerEndDown1 = self.childNode(withName: "ComputerEndDown1") as! SKSpriteNode
        if let cpd1Value = computerPile1.last?.value, let cpd1Suit = computerPile1.last?.suit {
            computerEndDown1.texture = SKTexture (imageNamed: "\(cpd1Value) \(cpd1Suit)")
        }
        let playerDown2 = self.childNode(withName: "PlayerDown2") as! SKSpriteNode
        if let ppd2Value = playerPile2.last?.value, let ppd2Suit = playerPile1.last?.suit {
            playerDown2.texture = SKTexture (imageNamed: "\(ppd2Value) \(ppd2Suit)")
        }
        let computerEndDown2 = self.childNode(withName: "ComputerEndDown2") as! SKSpriteNode
        if let cpd2Value = computerPile2.last?.value, let cpd2Suit = computerPile2.last?.suit {
            computerEndDown2.texture = SKTexture (imageNamed: "\(cpd2Value) \(cpd2Suit)")
        }
        let playerDown3 = self.childNode(withName: "PlayerDown3") as! SKSpriteNode
        if let ppd3Value = playerPile3.last?.value, let ppd3Suit = playerPile3.last?.suit {
            playerDown3.texture = SKTexture (imageNamed: "\(ppd3Value) \(ppd3Suit)")
        }
        let computerEndDown3 = self.childNode(withName: "ComputerEndDown3") as! SKSpriteNode
        if let cpd3Value = computerPile3.last?.value, let cpd3Suit = computerPile3.last?.suit {
            computerEndDown3.texture = SKTexture (imageNamed: "\(cpd3Value) \(cpd3Suit)")
            
        }
        
        //at the end of the game, when the real cards behind these fake cards are played, we will perform an if statement which basically says that if those cards are played, simultaneously the respective fake card will dissappear
        let fakeCardBack1 = self.childNode(withName: "Fake1") as! SKSpriteNode
        fakeCardBack1.texture = SKTexture (imageNamed: "1 card")
        let fakeCardBack2 = self.childNode(withName: "Fake2") as! SKSpriteNode
        fakeCardBack2.texture = SKTexture (imageNamed: "1 card")
        let fakeCardBack3 = self.childNode(withName: "Fake3") as! SKSpriteNode
        fakeCardBack3.texture = SKTexture (imageNamed: "1 card")
        let fakeCardBack4 = self.childNode(withName: "Fake4") as! SKSpriteNode
        fakeCardBack4.texture = SKTexture (imageNamed: "1 card")
        let fakeCardBack5 = self.childNode(withName: "Fake5") as! SKSpriteNode
        fakeCardBack5.texture = SKTexture (imageNamed: "1 card")
        let fakeCardBack6 = self.childNode(withName: "Fake6") as! SKSpriteNode
        fakeCardBack6.texture = SKTexture (imageNamed: "1 card")
 
        
        
        //cards on the top
        let playerUp1 = self.childNode(withName: "PlayerUp1") as! SKSpriteNode
        if let pp1Value = playerPile4.last?.value, let pp1Suit = playerPile4.last?.suit {
            playerUp1.texture = SKTexture (imageNamed: "\(pp1Value) \(pp1Suit)")
        }//player up 1
        let computerEndUp1 = self.childNode(withName: "ComputerEndUp1") as! SKSpriteNode
        if let cp1Value = computerPile4.last?.value, let cp1Suit = computerPile4.last?.suit {
            computerEndUp1.texture = SKTexture (imageNamed: "\(cp1Value) \(cp1Suit)")
        }//computer up 1
        
        let PlayerUp2 = self.childNode(withName: "PlayerUp2") as! SKSpriteNode
        if let pp2Value = playerPile5.last?.value, let pp2Suit = playerPile5.last?.suit {
            PlayerUp2.texture = SKTexture (imageNamed: "\(pp2Value) \(pp2Suit)")
        }//player up 2
        
        let computerEndUp2 = self.childNode(withName: "ComputerEndUp2") as! SKSpriteNode
        if let cp2Value = computerPile5.last?.value, let cp2Suit = computerPile5.last?.suit {
            computerEndUp2.texture = SKTexture (imageNamed: "\(cp2Value) \(cp2Suit)")
        }//computer up 2
        
        let playerUp3 = self.childNode(withName: "PlayerUp3") as! SKSpriteNode
        if let pp3Value = playerPile6.last?.value, let pp3Suit = playerPile6.last?.suit {
            playerUp3.texture = SKTexture (imageNamed: "\(pp3Value) \(pp3Suit)")
        }//player up 3
        
        let computerEndUp3 = self.childNode(withName: "ComputerEndUp3") as! SKSpriteNode
        if let cp3Value = computerPile6.last?.value, let cp3Suit = computerPile6.last?.suit {
            computerEndUp3.texture = SKTexture (imageNamed: "\(cp3Value) \(cp3Suit)")
        } //computer up 3
        
        
        
        let drawPile = self.childNode(withName: "DrawPile") as! SKSpriteNode
        drawPile.texture = SKTexture (imageNamed: "1 card")
        
        
       
        var offsetX : CGFloat = 0
        for card in playerHandPile {
            let cardNode = SKSpriteNode (imageNamed: "\(card.value) \(card.suit)")
            cardNode.size = CGSize (width: 145, height: 200)
            cardNode.position = CGPoint (x: 150 + offsetX, y: -size.height / 2)
            addChild(cardNode)
            offsetX += 130
            
        }
        for card in computerHandPile {
            let cardNode2 = SKSpriteNode (imageNamed: "\(card.value) \(card.suit)")
            cardNode2.size = CGSize (width: 145, height: 200)
            cardNode2.position = CGPoint (x: offsetX - 150, y: size.height/2)
            addChild(cardNode2)
            offsetX += 130
        }
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
