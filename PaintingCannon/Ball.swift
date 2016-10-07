import SpriteKit

class Ball : BaseObject {
    var readyToShoot = false
    var shootPaintSound = Sound("snd_shoot_paint")
    init() {
        super.init(redImage: "ball_red", greenImage: "ball_green", blueImage: "ball_blue")
        self.zPosition = 1
        self.isHidden = true
    }
    
    convenience init(position: CGPoint) {
        self.init()
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleInput(_ inputHelper: InputHelper)
    {
        let localTouch: CGPoint = GameScene.world.node.convert(inputHelper.touchLocation, to: GameScene.world.cannon.red)
        if inputHelper.isTouching() && !GameScene.world.cannon.red.frame.contains(localTouch) && self.isHidden {
            readyToShoot = true
        }
        if (!inputHelper.isTouching() && readyToShoot && self.isHidden) {
            self.isHidden = false
            readyToShoot = false
            velocity.x = (inputHelper.touchLocation.x - GameScene.world.cannon.position.x) * 1.4
            velocity.y = (inputHelper.touchLocation.y - GameScene.world.cannon.position.y) * 1.4
            shootPaintSound.play()
        }
    }
    
    override func updateDelta(_ delta: TimeInterval)
    {
        if !self.isHidden {
            velocity.x *= 0.99
            velocity.y -= 15
            self.position.x += velocity.x * CGFloat(delta)
            self.position.y += velocity.y * CGFloat(delta)
        }
        else {
            // calculate the ball position
            let cannonBarrel = GameScene.world.cannon.barrel
            let cannonNode = GameScene.world.cannon
            let opposite = sin(cannonBarrel.zRotation) * cannonBarrel.size.width * 0.6
            let adjacent = cos(cannonBarrel.zRotation) * cannonBarrel.size.width * 0.6
            self.position = CGPoint(x: cannonNode.position.x + adjacent, y: cannonNode.position.y + opposite)
            
            // set the ball color
            red.isHidden = GameScene.world.cannon.red.isHidden
            green.isHidden = GameScene.world.cannon.green.isHidden
            blue.isHidden = GameScene.world.cannon.blue.isHidden
        }
        if GameScene.world.isOutsideWorld(self.position) {
            self.isHidden = true
            readyToShoot = false
        }
    }

    override func reset()
    {
        self.isHidden = true
        readyToShoot = false
    }
}
