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
    static var InitialSwap = 0
    static var PlayerTurn = 1
    static var ComputerTurn = 2
    static var GameOver = 3
    
    
}


class GameScene: SKScene {
   /* class SKFieldNode {
        SKFieldNode.CreateSpringField () {
        fieldNode.Enabled = true
        fieldNode.Position = new PointF (Size.Width / 2, 0)
        fieldNode.Strength = 0.5f
        fieldNode.Region = new SKRegion(Frame.Size)
        addChild (fieldNode)
        }
        public override void TouchesBegan (NSSet touches, UIEvent evt) {
        var touch = touches.AnyObject as UITouch;
        var pt = touch.LocationInNode (this);
        
        var node = SKSpriteNode.FromImageNamed ("TinyBanana");
        node.PhysicsBody = SKPhysicsBody.Create (node.Texture, node.Size);
        node.PhysicsBody.AffectedByGravity = false;
        node.PhysicsBody.AllowsRotation = true;
        node.PhysicsBody.Mass = 0.03f;
        
        node.Position = pt;
        AddChild (node);
        }
    }*/
    
    
    var masterZPosition: CGFloat = 5
    
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
        //remove cards computerHandCards and playerhandCards//
        for card in computerHandPile {
            card.removeFromParent()
        }
        for card in playerHandPile {
            card.removeFromParent()
        }
        
        let playedPileTop = self.childNode(withName: "Play Pile Top") as! SKSpriteNode
        let playedPileUpperMiddle = self.childNode(withName: "Play Pile Upper Middle") as! SKSpriteNode
        let playedPileLowerMiddle = self.childNode(withName: "Play Pile Lower Middle") as! SKSpriteNode
        let playedPileBottom = self.childNode(withName: "Play Pile Bottom") as! SKSpriteNode
        playedPileTop.alpha = 1
        playedPileUpperMiddle.alpha = 1
        playedPileLowerMiddle.alpha = 1
        playedPileBottom.alpha = 1
        
        if playedPile.count >= 4 {
            playedPileTop.texture = playedPile.last?.texture //how we get last card//
            playedPileUpperMiddle.texture = playedPile[playedPile.count - 2].texture
            playedPileLowerMiddle.texture = playedPile[playedPile.count - 3].texture
            playedPileBottom.texture = playedPile [playedPile.count - 4].texture

        }
        else if playedPile.count == 3 {
            playedPileTop.texture = playedPile.last?.texture
            playedPileUpperMiddle.texture = playedPile[playedPile.count - 2].texture
            playedPileLowerMiddle.texture = playedPile[playedPile.count - 3].texture
            playedPileBottom.alpha = 0
        }
        else if playedPile.count == 2 {
            playedPileTop.texture = playedPile.last?.texture
            playedPileUpperMiddle.texture = playedPile[playedPile.count - 2].texture
            playedPileLowerMiddle.alpha = 0
            playedPileBottom.alpha = 0
        }
        else if playedPile.count == 1 {
            playedPileTop.texture = playedPile.last?.texture
            playedPileUpperMiddle.alpha = 0
            playedPileLowerMiddle.alpha = 0
            playedPileBottom.alpha = 0
        }
        else {
            playedPileTop.alpha = 0 //alpha is transparency, 0 being clear, one being opaque//
            playedPileUpperMiddle.alpha = 0
            playedPileLowerMiddle.alpha = 0
            playedPileBottom.alpha = 0
        }
        
        let playerDown1 = self.childNode(withName: "PlayerDown1") as! SKSpriteNode
        playerDown1.texture = SKTexture (imageNamed: "1 card")
        
        
        let computerEndDown1 = self.childNode(withName: "ComputerEndDown1") as! SKSpriteNode
        computerEndDown1.texture = SKTexture (imageNamed: "1 card")
        
        let playerDown2 = self.childNode(withName: "PlayerDown2") as! SKSpriteNode
        playerDown2.texture = SKTexture (imageNamed: "1 card")
    
        let computerEndDown2 = self.childNode(withName: "ComputerEndDown2") as! SKSpriteNode
        computerEndDown2.texture = SKTexture (imageNamed: "1 card")
        
        let playerDown3 = self.childNode(withName: "PlayerDown3") as! SKSpriteNode
        playerDown3.texture = SKTexture (imageNamed: "1 card")
        
        let computerEndDown3 = self.childNode(withName: "ComputerEndDown3") as! SKSpriteNode
        computerEndDown3.texture = SKTexture (imageNamed: "1 card")
    
        
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
        
        let playerUp2 = self.childNode(withName: "PlayerUp2") as! SKSpriteNode
        if let pp2Value = playerPile5.last?.value, let pp2Suit = playerPile5.last?.suit {
            playerUp2.texture = SKTexture (imageNamed: "\(pp2Value) \(pp2Suit)")
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
            card.position = CGPoint (x: 90 + offsetX, y: -size.height / 2.2)
            card.zPosition = masterZPosition
            masterZPosition += 1
            card.size = CGSize (width: 90, height: 130)
            addChild(card)
            offsetX += 90
        }
        offsetX = size.width
        for card in computerHandPile {
            card.position = CGPoint (x: offsetX - 90, y: size.height/2)
            card.texture = SKTexture (imageNamed: "1 card")
            addChild(card)
            
            offsetX -= 90
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location (in: self)
        
        let label = SKLabelNode(fontNamed: "Arial") //label one declaration
                label.text = "You cannot play a LOWER number."
                label.fontColor = UIColor.white
                label.fontSize = 40
                label.position = CGPoint(x: size.width/2, y: -110)
                label.zPosition = 2
                label.alpha = 0
        let label2 = SKLabelNode(fontNamed: "Arial") //label 2 declaration
                label2.text = "Punishment: take the deck"
                label2.fontColor = UIColor.white
                label2.fontSize = 40
                label2.position = CGPoint(x: size.width/2, y: -160)
                label2.zPosition = 2
                label.alpha = 0
        let label2Magic = SKLabelNode (fontNamed: "Arial Bold")
                label2Magic.text = "RESET 2!"
                label2Magic.fontColor = UIColor.blue
                label2Magic.fontSize = 175
                label2Magic.position = CGPoint(x: size.width/2, y: 0)
                label2Magic.zPosition = 2
                label2Magic.alpha = 0
        let label10Magic = SKLabelNode (fontNamed: "Arial Bold")
                label10Magic.text = "BURN 10!"
                label10Magic.fontColor = UIColor.red
                label10Magic.fontSize = 175
                label10Magic.position = CGPoint(x: size.width/2, y: 0)
                label10Magic.zPosition = 2
                label10Magic.alpha = 0
    
        let label7Magic = SKLabelNode (fontNamed: "Arial Bold")
                label7Magic.text = "BELOW 7!"
                label7Magic.fontColor = UIColor.black
                label7Magic.fontSize = 175
                label7Magic.position = CGPoint(x: size.width/2, y: 0)
                label7Magic.zPosition = 2
                label7Magic.alpha = 0
        let label7Error = SKLabelNode(fontNamed: "Arial Bold") //label one declaration
                label7Error.text = "You MUST play a LOWER number."
                label7Error.fontColor = UIColor.white
                label7Error.fontSize = 40
                label7Error.position = CGPoint(x: size.width/2, y: -110)
                label7Error.zPosition = 2
                label7Error.alpha = 0
         let x: Int = playedPile.count + playerHandPile.count + drawPile.count + computerHandPile.count
        
        
        
        for card in playerHandPile {
            if card.contains(touchLocation) {  //                           //if the card is touched
                if playedPile.count <= 0 {                                                  //and if the played pile has no cards
                    let i = playerHandPile.index(of: card)                                  //take the touched card
                    playerHandPile.remove(at: i!)
                    card.removeFromParent()
                    playedPile.append(card)                                                 //take a card from draw pile and put in player pile
                    label.run(SKAction.removeFromParent())                                  //remove any previous labels
                    label2.run(SKAction.removeFromParent())
                    label2Magic.run(SKAction.removeFromParent())
                    print (x)
                    break
//add breasks to every if statement but only after card.removeFromParent () and it goes at end only on these
                }
//                                                          ||||||||||||||||||||||||||||||||||||||||||||||||
//                                                        ||||||||||||||||||||||||||||||||||||||||||||||||||
//                                                        ||||||||||||||||||||||||||||||||||||||||||||||||||
//                                                        ||||||||||||||||||||||||||||||||||||||||||||||||||
//                                                        |||||||||                       ||||||||||||||||||
//                                                        |||||||                           ||||||||||||||||
//                                                        |||                                 ||||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                                              ||||||||||||
//                                                                  ||||||||||||||||||||||||||||||||||||||||
//                                                              ||||||||||||||||||||||||||||||||||||||||||||
//                                                            ||||||||||||||||||||||||||||||||||||||||||||||
//                                                           |||||||||||||||||||||||||||||||||||||||||||||||
//                                                        |||||||||||||||||           |||||||||||||||||||||||
//                                                        ||||||||||||||||             |||||||||||||||||||||
//                                                        |||||||||||||||               ||||||||||||||||||||
//                                                        ||||||||||||||                 |||||||||||||||||||
//                                                        |||||||||||||                   ||||||||||||||||||
//                                                        ||||||||||||                     |||||||||||||||||
//                                                        ||||||||||||                     |||||||||||||||||
//                                                        ||||||||||||                     |||||||||||||||||
//                                                        ||||||||||||                     |||||||||||||||||
//                                                        |||||||||||||                   ||||||||||||||||||
//                                                        ||||||||||||||                 |||||||||||||||||||
//                                                        |||||||||||||||               ||||||||||||||||||||
//                                                        ||||||||||||||||             |||||||||||||||||||||
//                                                        |||||||||||||||||           ||||||||||||||||||||||
//                                                        ||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//                                                        ||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//                                                        ||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//                                                        ||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                    // put special cards here
                else if card.value == 1{ //                                 SPECIAL 2
                    if playedPile.count >= 0  {
                        let i = playerHandPile.index(of: card)
                            playerHandPile.remove(at: i!)
                            card.removeFromParent()
                            playedPile.append(card)
                            
                            addChild(label2Magic)
                            label2Magic.run(SKAction.sequence([
                                SKAction.fadeIn(withDuration: 0.5),
                                SKAction.wait(forDuration: 2),
                                SKAction.fadeOut(withDuration: 0.5),
                                SKAction.removeFromParent()
                                ]))
                            print ("2 played")
                            print (x)
                        break
                    }
                    if playedPile.count == 0 {
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        
                        addChild(label2Magic)
                        label2Magic.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2),
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                            ]))
                        print ("2 played")
                        print (x)
                        break
                    }
   
                }
                    
//                                                                       |||||||                |||||||||||
//                                                                       |||||||               |||||||||||||
//                                                                       |||||||              |||         ||||
//                                                                       |||||||             |||           ||||
//                                                                       |||||||            |||             ||||
//                                                                       |||||||           ||||               ||||
//                                                                       |||||||           ||||               ||||
//                                                                       |||||||            ||||             ||||
//                                                                       |||||||             ||||           ||||
//                                                                       |||||||              ||||         ||||
//                                                                       |||||||               ||||       ||||
//                                                                       |||||||                |||||||||||||
//                                                                       |||||||                 |||||||||
                    
                else if card.value == 10 { //special 10 power
                    if playedPile.count >= 0 {
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        playedPile.removeAll()
                        addChild(label10Magic)
                        label10Magic.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2),
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                            ]))
                        print (x)
                        print ("10 played")
                        break
                    }
                    if playedPile.count == 0 {
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        playedPile.removeAll()
                        addChild(label10Magic)
                        label10Magic.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2),
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                        ]))
                        print (x)
                        print ("10 played")
                        break
                    }
                }
//                                                                         |||||||||||||||||||||||||||||||||||||||
//                                                                         |||||||||||||||||||||||||||||||||||||||
//                                                                         |||||||||||||||||||||||||||||||||||||||
//                                                                         |||||||||||||||||||||||||||||||||||||||
//                                                                                                ||||||||||||||||
//                                                                                               ||||||||||||||||
//                                                                                              ||||||||||||||||
//                                                                                             ||||||||||||||||
//                                                                                            ||||||||||||||||
//                                                                                           ||||||||||||||||
//                                                                                         ||||||||||||||||
//                                                                                        ||||||||||||||||
//                                                                                        |||||||||||||||
//                                                                                       |||||||||||||||
//                                                                                       ||||||||||||||
//                                                                                       |||||||||||||
//                                                                                       |||||||||||||
//                                                                                       |||||||||||||
//                                                                                       |||||||||||||
//                                                                                       |||||||||||||
//                                                                                       |||||||||||||
//                                                                                       |||||||||||||
//                                                                                       |||||||||||||
                    
                    
                else if playedPile.count >= 0 && card.value == 7 { //special 7 power
                    let i = playerHandPile.index(of: card)
                    playerHandPile.remove(at: i!)
                    card.removeFromParent()
                    playedPile.append(card)
                    addChild(label7Magic)
                    label7Magic.run(SKAction.sequence([
                        SKAction.fadeIn(withDuration: 0.5),
                        SKAction.wait(forDuration: 2),
                        SKAction.fadeOut(withDuration: 0.5),
                        SKAction.removeFromParent()
                        ]))
                    print (x)
                    print ("7 played")
                    break


                }
                    
                else if playedPile.count > 0 && (playedPile.last?.value == 7)  { //following a seven
                    if card.value <= (playedPile.last?.value)! {
                        
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        
                        print (x)
                        print ("good after 7 played")
                        break
                    }
                    if (card.value > 7 && card.value != 11 && card.value != 10) {                     //bad following a 7
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        playerHandPile.append(contentsOf: playedPile)
                        playedPile.removeAll()
                        addChild(label7Error)
                        label7Error.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2),
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                            ]))
                        addChild(label2)
                        label2.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2),
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                            ]))
                        print (x)
                        print ("bad after 7 played")
                        break
                    }
                    if playedPile.count >= 0 && card.value == 11 {
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        print (x)
                        print ("jack played")
                        break
                    }
                    if card.value == 10 {
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        print (x)
                        print ("10 played after a 7")
                        break
                    }
                
                }
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
//                                                              |||||||||||||||          |||||||||||||||
                    
                    
                 
                    
                    
                    
                else if playedPile.count >= 0 && card.value == 11 {
                    let i = playerHandPile.index(of: card)
                    playerHandPile.remove(at: i!)
                    card.removeFromParent()
                    playedPile.append(card)
                    print (x)
                    print ("jack played")
                    break

                }
                
                    
                else if card.value == 11{
                    if playerHandPile[playerHandPile.count-2].value != 7 && playedPile.count >= 2 && card.value >= playedPile[playedPile.count-2].value{
                        //if following jack and there are already two cards in playedPile. also not a seven and the card is higher than the previous card
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        print ("good after jack played")
                        break

                        
                    } else if playedPile.count <= 1 {                          // if following jack and there are not two cards in playedPile yet
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        print ("first card is jack played")
                        break

                        
                    } else if playedPile.count >= 2 && card.value <= playedPile[playedPile.count-2].value && playedPile[playedPile.count-2].value != 7 && card.value != 2{
                        //if following a jacka nd the played card is not higher than the card and is not a 7
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        playerHandPile.append(contentsOf: playedPile)
                        playedPile.removeAll()
                        print ("bad after jack played. you played lower than the card behind the jack.")
                        addChild(label)
                        addChild(label2)
                        break
                    }
                        
                        
                    else if playedPile[playedPile.count-2].value == 2 {     //joker then jack
                        if card.value == 2 {
                            let i = playerHandPile.index(of: card)
                            playerHandPile.remove(at: i!)
                            card.removeFromParent()
                            playedPile.append(card)
                            computerHandPile.append(contentsOf: playedPile)
                            playedPile.removeAll()
                            print ("the cared before thisjack was a joker. it should do the joker thing now")
                            break
                        }
                    }
                    else if playedPile[playedPile.count-2].value == 7 {
                        if card.value > 7 {
                            let i = playerHandPile.index(of: card)
                            playerHandPile.remove(at: i!)
                            card.removeFromParent()
                            playedPile.append(card)
                            playerHandPile.append(contentsOf: playedPile)
                            playedPile.removeAll()
                            addChild(label7Error)
                            label7Error.run(SKAction.sequence([
                                SKAction.fadeIn(withDuration: 0.5),
                                SKAction.wait(forDuration: 2),
                                SKAction.fadeOut(withDuration: 0.5),
                                SKAction.removeFromParent()
                                ]))
                            addChild(label2)
                            label2.run(SKAction.sequence([
                                SKAction.fadeIn(withDuration: 0.5),
                                SKAction.wait(forDuration: 2),
                                SKAction.fadeOut(withDuration: 0.5),
                                SKAction.removeFromParent()
                                ]))
                            print (x)
                            print ("bad card after jack and 7 played")
                            break
                        }
                        if card.value <= 7 {
                            let i = playerHandPile.index(of: card)
                            playerHandPile.remove(at: i!)                                              //take the card and put into played pile and array
                            card.removeFromParent()
                            playedPile.append(card)
                            print (x)
                            print ("good card after jack and 7 turn played")
                        }
                    }
                        
                    print (x)

                }
//                                                           _________________________
//                                                           |||||||||||||||||||||||||
//                                                           |||||||||||||||||||||||||
//                                                           |||||||||||||||||||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                                                   ||||||||
//                                              ||||||||||||||       ||||||||
//                                              ||||||||||||||       ||||||||
//                                              ||||||||||||||       ||||||||
//                                                 |||||||||         ||||||||
//                                                  |||||||||       ||||||||
//                                                   |||||||||||||||||||||
//                                                     ||||||||||||||||||
                    
                    
                    
                    
                    
                    
                else if card.value == 2 { //         
                     if playedPile[playedPile.count-1].value == 11 {
                        if playedPile.count >= 2 {
                            let i = playerHandPile.index(of: card)
                            playerHandPile.remove(at: i!)
                            card.removeFromParent()
                            playedPile.append(card)
                            computerHandPile.append(contentsOf: playedPile)
                            playedPile.removeAll()
                            print ("joker after jack")
                            break
                        }
                    }
                    if playedPile.count == 0 {
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        computerHandPile.append(contentsOf: playedPile)
                        playedPile.removeAll()
                        print ("joker played")
                        break
                    }
                    if playedPile.count >= 1{
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        computerHandPile.append(contentsOf: playedPile)
                        playedPile.removeAll()
                        print ("joker starts the pile")
                        break
                    }
                   
                    if  playedPile.count >=  2 && playedPile[playedPile.count-1].value == 11{
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        computerHandPile.append(contentsOf: playedPile)
                        playedPile.removeAll()
                        print ("joker played after jack")
                        break
                    }
                }
                else if playedPile.count > 0 && card.value >= (playedPile.last?.value)! {  //IF THE playedPile has cards and you are playing a greater card than last
                    let i = playerHandPile.index(of: card)
                    playerHandPile.remove(at: i!)                                              //take the card and put into played pile and array
                    card.removeFromParent()
                    playedPile.append(card)
                    print (x)
                    print ("regular turn played")
                    break

    
                }
                    
                    
                else if playedPile.count > 0 && card.value < (playedPile.last?.value)! {   //invalid card play
                    let i = playerHandPile.index(of: card)
                    playerHandPile.remove(at: i!)
                    card.removeFromParent()
                    playedPile.append(card)
                    playerHandPile.append(contentsOf: playedPile)
                    playedPile.removeAll()
                    print (x)
                    print ("invalid lower card after higher card")
                    addChild(label)
                    label.run(SKAction.sequence([                                           //print label
                        SKAction.fadeIn(withDuration: 0.5),
                        SKAction.wait(forDuration: 2),
                        SKAction.fadeOut(withDuration: 0.5),
                        SKAction.removeFromParent()
                        ]))
                    
                    addChild(label2)
                    label2.run(SKAction.sequence([                                          //print label2
                        SKAction.fadeIn(withDuration: 0.5),
                        SKAction.wait(forDuration: 2),
                        SKAction.fadeOut(withDuration: 0.5),
                        SKAction.removeFromParent()
                        ]))
                    break
   
                }
                    
                /*else if playedPile.count > 0 && card.value < (playedPile.last?.value)! {                                                                      // if someone tries to play a card that is below the card in the pile invalid//
                    let i = playerHandPile.index(of: card)
                    playerHandPile.remove(at: i!)
                    card.removeFromParent()
                    playedPile.append(card)
                    playerHandPile.append(contentsOf: playedPile)//give all played cards to invalid card player
                    playedPile.removeAll()
                    print (x)
                    
                    
                    addChild(label)
                    
                    label.run(SKAction.sequence([                                           //print label
                        SKAction.fadeIn(withDuration: 0.5),
                        SKAction.wait(forDuration: 2),
                        SKAction.fadeOut(withDuration: 0.5),
                        SKAction.removeFromParent()
                        ]))
                    addChild(label2)
                    label2.run(SKAction.sequence([                                          //print label2
                        SKAction.fadeIn(withDuration: 0.5),
                        SKAction.wait(forDuration: 2),
                        SKAction.fadeOut(withDuration: 0.5),
                        SKAction.removeFromParent()
                        ]))
                    
                    
                   

                }
               */
            }
            
            
        }
        
        if drawPile.count > 0 {                                                                //if the draw pile still has cards
            let card = drawPile.last
            card?.zPosition += 1                                                               //give a card
            let i = drawPile.index(of: card!)
            drawPile.remove(at: i!)
            playerHandPile.append(card!)
        }
       else { }                                                                             //if the draw pile is empty, get rid of the fake card representing it
        updateCardUI()
        SKSpriteNode (imageNamed: "1 card")
       
        //print(playerHandPile)
    }
  

  
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

