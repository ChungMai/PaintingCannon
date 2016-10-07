import SpriteKit

class GameScene: SKScene {
    
    var delta: TimeInterval = 1/60
    var inputHelper = InputHelper()
    static var world = GameWorld()

    override init(size: CGSize)
    {
        super.init(size: size)
        GameScene.world.size = size
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func didMove(to view: SKView)
    {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(GameScene.world.node)

        delta = TimeInterval(view.frameInterval) / 60
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        GameScene.world.handleInput(inputHelper)
        GameScene.world.updateDelta(delta)
        inputHelper.hasTapped = false
    }
    
    // Touch input handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if(GameScene.world.live.numberLive > 0){
            let touch = touches.first!
            inputHelper.touchLocation = touch.location(in: self)
            inputHelper.nrTouches = inputHelper.nrTouches + touches.count
            inputHelper.hasTapped = true
        }
        else{
            GameScene.world.reset()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first!
        inputHelper.touchLocation = touch.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        inputHelper.nrTouches -= touches.count
        if(inputHelper.nrTouches < 0){
           inputHelper.nrTouches = 0
        }  
    }
}
