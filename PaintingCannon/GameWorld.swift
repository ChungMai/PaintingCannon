import SpriteKit

class GameWorld {
    
    var size = CGSize()
    var node = SKNode()
    var background = SKSpriteNode(imageNamed: "background")
    var gameover = SKSpriteNode(imageNamed: "gameover")
    var board = SKSpriteNode(imageNamed:"oldparchment")
    var scoreLab = SKLabelNode()
    var cannon = Cannon()
    var ball = Ball()
    var can1 = PaintCan(pOffset: -10, targetColor: UIColor.red)
    var can2 = PaintCan(pOffset: 190, targetColor: UIColor.green)
    var can3 = PaintCan(pOffset: 390, targetColor: UIColor.blue)
    var live = Live()
    var score = 0
    var backgroundMusic = Sound("snd_music")
    
    init()
    {
        board.position = CGPoint(x: -410, y: 280)
        scoreLab.position = CGPoint(x: -390, y: 220)
        background.zPosition = 0
        gameover.zPosition = 2
        board.zPosition = 3
        scoreLab.zPosition = 4
        scoreLab.text = "Score: \(score)"
        scoreLab.fontSize = 40.0
        node.addChild(background)
        node.addChild(cannon)
        node.addChild(ball)
        node.addChild(can1)
        node.addChild(can2)
        node.addChild(can3)
        node.addChild(live)
        node.addChild(gameover)
        node.addChild(board)
        node.addChild(scoreLab)        
        gameover.isHidden = true
        
        // play background music
        backgroundMusic.looping = true
        backgroundMusic.volume = 0.5
       // backgroundMusic.play()
    }
    
    func handleInput(_ inputHelper: InputHelper)
    {
            cannon.handleInput(inputHelper)
            ball.handleInput(inputHelper)
    }

    func updateDelta(_ delta: TimeInterval)
    {
        ball.updateDelta(delta)
        can1.updateDelta(delta)
        can2.updateDelta(delta)
        can3.updateDelta(delta)
        scoreLab.text = "Score: \(score)"
    }
    
    func isOutsideWorld(_ pos: CGPoint) -> Bool
    {
        return pos.x < -size.width/2 || pos.x > size.width/2 || pos.y < -size.height/2
    }
    
    func reset()
    {
        gameover.isHidden = true
        score = 0
        scoreLab.text = "Score: \(score)"
        ball.reset()
        can1.reset()
        can2.reset()
        can3.reset()
        live.reset()
    }
}
