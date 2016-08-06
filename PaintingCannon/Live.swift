//
//  Live.swift
//  Painter5
//
//  Created by Home on 7/27/16.
//  Copyright © 2016 Arjan Egges. All rights reserved.
//
import SpriteKit
import Foundation

class Live : SKNode
{
    var numberLive = 3
    
    override init()
    {
        super.init()
        for index in 0 ..< numberLive {
            let livesSpr = SKSpriteNode(imageNamed: "lives")
            livesSpr.position = CGPoint(x: -510 + index * Int(livesSpr.size.width), y: 300)
            self.addChild(livesSpr)
            self.zPosition = 4
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLive()
    {
        for index in 0 ..< self.children.count
        {
            let live =  self.children[index] as SKNode
            live.hidden = index >= GameScene.world.live.numberLive
            
        }
    }
    
    func reset(){
        numberLive = 3
        for index in 0 ..< self.children.count
        {
            let live =  self.children[index] as SKNode
            live.hidden = false
            
        }
    }
}
