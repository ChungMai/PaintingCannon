import SpriteKit

func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
}

class PaintCan :  BaseObject{
    
    var positionOffset = CGFloat(0)
    var minVelocity = CGFloat(100)
    var targetColor = UIColor.redColor()
    var collectPointsSound = Sound("snd_collect_points")
    
    init(pOffset: CGFloat, targetColor : UIColor)
    {
        super.init(redImage: "can_red", greenImage:  "can_green", blueImage: "can_blue")
        positionOffset = pOffset
        self.zPosition = 1
        self.hidden = true
        self.targetColor = targetColor;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateDelta(delta : NSTimeInterval)
    {
        if self.hidden
        {
            if randomCGFloat() > 0.01 {
                return
            }
            
            self.hidden = false;
            self.position = CGPoint(x:positionOffset, y: GameScene.world.size.height/2 + red.size.height/2 + 5)
            velocity = CGPoint(x:0.0, y: randomCGFloat() * -40 - minVelocity)
            let color = arc4random_uniform(3);
            red.hidden = color != 0
            green.hidden = color != 1
            blue.hidden = color != 2
        }
        
        self.position.x += velocity.x * CGFloat(delta)
        self.position.y += velocity.y * CGFloat(delta)
        
        let bottomPosition = CGPoint(x:self.position.x, y: self.position.y + red.size.height/2)
        if GameScene.world.isOutsideWorld(bottomPosition){
            self.hidden = true
            if(color != targetColor){
               GameScene.world.live.numberLive = GameScene.world.live.numberLive - 1
               GameScene.world.live.updateLive()
               GameScene.world.gameover.hidden = GameScene.world.live.numberLive != 0
            }
            else{
                GameScene.world.score = (GameScene.world.live.numberLive > 0) ? (GameScene.world.score + 1) : GameScene.world.score;
            }
        }
        else{
            if self.box.intersects(GameScene.world.ball.box) {
                color = GameScene.world.ball.color
                GameScene.world.ball.reset()
                collectPointsSound.play()
            }
        }
        
        //minVelocity += 0.02
        self.zRotation = sin(position.y / 50) * 0.04
    }
    
    
    override func reset(){
        self.hidden = true
    }
}