import SpriteKit

class Ball : BaseObject {
    var readyToShoot = false
    var shootPaintSound = Sound("snd_shoot_paint")
    init() {
        super.init(redImage: "ball_red", greenImage: "ball_green", blueImage: "ball_blue")
        self.zPosition = 1
        self.hidden = true
    }
    
    convenience init(position: CGPoint) {
        self.init()
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleInput(inputHelper: InputHelper)
    {
        let localTouch: CGPoint = GameScene.world.node.convertPoint(inputHelper.touchLocation, toNode: GameScene.world.cannon.red)
        if inputHelper.isTouching() && !GameScene.world.cannon.red.frame.contains(localTouch) && self.hidden {
            readyToShoot = true
        }
        if (!inputHelper.isTouching() && readyToShoot && self.hidden) {
            self.hidden = false
            readyToShoot = false
            velocity.x = (inputHelper.touchLocation.x - GameScene.world.cannon.position.x) * 1.4
            velocity.y = (inputHelper.touchLocation.y - GameScene.world.cannon.position.y) * 1.4
            shootPaintSound.play()
        }
    }
    
    override func updateDelta(delta: NSTimeInterval)
    {
        if !self.hidden {
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
            red.hidden = GameScene.world.cannon.red.hidden
            green.hidden = GameScene.world.cannon.green.hidden
            blue.hidden = GameScene.world.cannon.blue.hidden
        }
        if GameScene.world.isOutsideWorld(self.position) {
            self.hidden = true
            readyToShoot = false
        }
    }

    override func reset()
    {
        self.hidden = true
        readyToShoot = false
    }
}