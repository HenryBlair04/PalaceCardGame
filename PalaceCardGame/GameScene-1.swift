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
            //print (i)
        }
      /*  playerHandPile.append(Card(11, "Diamond"))
        playerHandPile.append(Card(11, "Diamond"))

        playerHandPile.append(Card(1, "RJoker"))
        playerHandPile.append(Card(1, "BJoker"))

        playerHandPile.append(Card(7, "Diamond"))
        playerHandPile.append(Card(7, "Diamond"))
        playerHandPile.append(Card(3, "Diamond"))
        playerHandPile.append(Card(13, "Diamond"))*/



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
            card.zPosition = masterZPosition
            card.size = CGSize (width: 90, height: 130)
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
        //let x: Int = playedPile.count + playerHandPile.count + drawPile.count + computerHandPile.count
        if state == GameState.PlayerTurn {
            for card in playerHandPile {
                if card.contains(touchLocation) {       // if the card is touched
                    if card.value == 10 {               // 10 is played
                        
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
                        //print ("10 played and burnt")
                        drawCard(turn: "player")
                        playComputerTurn()
                        break
                    }
                    else if card.value == 2{            // 2 is played
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
                        //print ("2 played")
                        drawCard (turn: "player")
                        playComputerTurn()
                        break
                    }
                    
                    else if card.value == 7 {           // seven is played
                        
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        //print("7 played")
                        drawCard (turn: "player")
                        playComputerTurn()

                        break
                    }
                        
                    else if card.value == 11 {          // jack is played
                        
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        //print("jack played")
                        drawCard (turn: "player")
                        playComputerTurn()
                        break
                    }
                        
                    else if card.value == 1 {           // joker is played
                        
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        
                        computerHandPile.append(contentsOf: playedPile)
                        playedPile = []
                        //print("joker played")
                        drawCard (turn: "player")
                        playComputerTurn()
                        break
                    }
                        
                    else if playedPile.count == 1 && playedPile.last?.value == 11{  // jack is played
                        
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        drawCard (turn: "player")
                        playComputerTurn()
                        break
                    }
                        
                    else if playedPile.count > 1 && playedPile.last?.value == 11{   // jack is played
                        var index = playedPile.count-2
                        while index > 0{
                            if playedPile[index].value == 11{
                                index -= 1
                            }
                            else {
                                break
                            }
                        }
                        
                        if playedPile[index].value == 7 && card.value <= 7{         // valid card played on a 7
                            
                            let i = playerHandPile.index(of: card)
                            playerHandPile.remove(at: i!)
                            card.removeFromParent()
                            playedPile.append(card)
                            drawCard (turn: "player")
                            playComputerTurn()
                        }
                        else if playedPile[index].value == 7 && card.value > 7{     // invalid card played on a 7
                            print("Must play a card lower than 7")
                            //must play card below 7
                        }
                        else if card.value >= playedPile[index].value{
                            
                            let i = playerHandPile.index(of: card)
                            playerHandPile.remove(at: i!)
                            card.removeFromParent()
                            playedPile.append(card)
                            drawCard (turn: "player")
                            playComputerTurn()
                        }
                        else{
                            addChild(label)
                            label.run(SKAction.sequence([
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
                        }
                        break
                    }
                        
                    else if playedPile.last?.value == 7 {
                        if card.value <= 7{                         // valid card is played on a 7
                            
                            moveFromHandToPile(card: card, turn: "player")
                            //let i = playerHandPile.index(of: card)
                            //playerHandPile.remove(at: i!)
                            card.removeFromParent()
                            //playedPile.append(card)
                            drawCard (turn: "player")
                            playComputerTurn()
                        }
                        else{                                       // invalid card is played on a 7
                            
                            //must play card below 7
                        }
                        break
                    }
                    else if playedPile.count == 0 {          // playedPile is empty
                        
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        drawCard (turn: "player")
                        playComputerTurn()
                        break
                    }
        
                    else if card.value >= (playedPile.last?.value)! {    // valid card is played
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        drawCard (turn: "player")
                        playComputerTurn()

                        break
                    }
                    
                    else if card.value < (playedPile.last?.value)!{                                          // invalid card is played
                        // do something
                        print("Cannot play that card")
                        let i = playerHandPile.index(of: card)
                        playerHandPile.remove(at: i!)
                        card.removeFromParent()
                        playedPile.append(card)
                        playerHandPile.append(contentsOf: playedPile)
                        playedPile = []
                        drawCard (turn: "player")
                        addChild(label)
                        label.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                            ]))
                        
                        addChild(label2)
                        label2.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5),
                            SKAction.removeFromParent()
                            ]))
                        
                        playComputerTurn()
                    }
                }
            }
        }
        
                                                  //if the draw pile is empty, get rid of the fake card representing it
        

        
        //print(playerHandPile)

    }
    func drawCard (turn: String ) {
        if turn == "player" {
            if drawPile.count > 0 {                                 //if the draw pile still has cards
                let card = drawPile.last
                card?.zPosition += 1                                //give a card
                let i = drawPile.index(of: card!)
                drawPile.remove(at: i!)
                playerHandPile.append(card!)
            }
            else { print ("no cards left in deck") }
        }
        else if turn == "computer" {
            if drawPile.count > 0 {                                 //if the draw pile still has cards
                let card = drawPile.last
                card?.zPosition += 1                                //give a card
                let i = drawPile.index(of: card!)
                drawPile.remove(at: i!)
                computerHandPile.append(card!)
                card?.texture = SKTexture(imageNamed: "1 card")
            }
            else { print ("no cards left in deck") }
        }
    }

    func playComputerTurn () {
        updateCardUI()
        state = GameState.ComputerTurn
        run(SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.run (computerTurn)]), completion:{
            print ("computer turn over")
            self.state = GameState.PlayerTurn
            self.updateCardUI()
        })
    }
    
    func computerTurn(){
        state = GameState.ComputerTurn
        run(SKAction.sequence([SKAction.wait(forDuration: 1.5)]))
        let c = self.findComputerCard()
        if c.suit != "Cannot Play A Card"{
            c.texture = SKTexture(imageNamed: "\(c.value) \(c.suit)")
            self.moveFromHandToPile(card: c, turn: "computer")
            self.drawCard(turn: "computer")
            self.state = GameState.PlayerTurn
        }
        else {
            print("give computer the pile")
            // give the computer the pile
            computerHandPile.append(contentsOf: playedPile)
            playedPile = []

        }
        updateCardUI()
    }
    
    /*func countPowerCards () {
       CFArrayGetCountOfValue(playedPile as CFArray, 0...54, [10, 11, 2, 7, 1] )!
        for card in playedPile {
            if card.value == 2 || card.value 7 ||
        }
    } */
    
    func moveFromHandToPile(card: Card, turn: String){
        if turn == "computer" && drawPile.count > 0{
            let i = computerHandPile.index(of: card)
            computerHandPile.remove(at: i!)
            playedPile.append(card)
            /*if drawPile.count > 0 {                                 //if the draw pile still has cards
                let card = drawPile.last
                card?.zPosition += 1                                //give a card to computer
                print ("computer played a card and recieved one")
            }*/
        }
        else if turn == "player" {
            let i = playerHandPile.index(of: card)
            playerHandPile.remove(at: i!)
            playedPile.append(card)
        }
        
    }
    
    func findComputerCard() -> Card{
        var selectedCard = Card(100, "Cannot Play A Card")
        if playedPile.count >= 0 && selectedCard.value == 10{              //computer plays a 10
            let i = computerHandPile.index(of: selectedCard)
            computerHandPile.remove(at: i!)
            playedPile.append(selectedCard)
            playedPile.removeAll()
            drawCard(turn: "computer")
        }
        if playedPile.count > 0 && playedPile.last?.value == 7{           //following a 7
            if selectedCard.value <= 7{
                let i = computerHandPile.index(of: selectedCard)
                computerHandPile.remove(at: i!)
                playedPile.append(selectedCard)
                drawCard(turn: "computer")
            }
            else{
                print("give computer the pile")
                // give the computer the pile
                computerHandPile.append(contentsOf: playedPile)
                playedPile = []
            }
        }
       else if selectedCard.value == 1 {
            print("give computer the pile")
            // give the computer the pile
            playerHandPile.append(contentsOf: playedPile)
            playedPile = []
        }
        else if playedPile.count > 1 && playedPile.last?.value == 11{   // jack is played
            var index = playedPile.count-2
            while index > 0{
                if playedPile[index].value == 11{
                    index -= 1
                }
                else {
                    break
                }
            }
        }
        
        for card in computerHandPile{
        
            if card.value <= selectedCard.value{
                if playedPile.count > 0 && card.value >= (playedPile.last?.value)!{
                    selectedCard = card
                }
                else if playedPile.count == 0{
                    selectedCard = card
                }
                else{
                    // card is less than minCard but also less than the card on the playedPile
                }
                
            
            }
        }
        return selectedCard
        
    }

  
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

