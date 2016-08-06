import SpriteKit

class Cannon :BaseObject{
    var barrel = SKSpriteNode(imageNamed:"cannon_barrel")

    init()
    {
        super.init(redImage: "cannon_red", greenImage: "cannon_green", blueImage: "cannon_blue")
        red.zPosition = 1
        green.zPosition = 1
        blue.zPosition = 1
        barrel.anchorPoint = CGPoint(x:0.233, y:0.5)
        self.position = CGPoint(x:-430, y:-280)
        self.zPosition = 1
        green.hidden = true
        blue.hidden = true
        self.addChild(barrel)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleInput(inputHelper: InputHelper)
    {
        if !inputHelper.isTouching() {
            return
        }
        
        let localTouch: CGPoint = GameScene.world.node.convertPoint(inputHelper.touchLocation, toNode: red)
        if !red.frame.contains(localTouch) {
            let opposite = inputHelper.touchLocation.y - self.position.y
            let adjacent = inputHelper.touchLocation.x - self.position.x
            barrel.zRotation = atan2(opposite, adjacent)
        }
        else if inputHelper.hasTapped {
            let tmp = blue.hidden
            blue.hidden = green.hidden
            green.hidden = red.hidden
            red.hidden = tmp
        }
    }
}
