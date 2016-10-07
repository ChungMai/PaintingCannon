//
//  BaseObject.swift
//  Painter5
//
//  Created by Home on 8/4/16.
//  Copyright © 2016 Arjan Egges. All rights reserved.
//

import Foundation
import SpriteKit

class BaseObject : SKNode
{
    var red = SKSpriteNode()
    var green = SKSpriteNode()
    var blue = SKSpriteNode()
    var velocity = CGPoint.zero
    
    init(redImage:String, greenImage:String,blueImage:String)
    {
        super.init();
        red = SKSpriteNode(imageNamed: redImage)
        green = SKSpriteNode(imageNamed: greenImage)
        blue = SKSpriteNode(imageNamed: blueImage)
        self.addChild(red)
        self.addChild(green)
        self.addChild(blue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var color : UIColor
    {
        get {
            if (!red.isHidden) {
                return UIColor.red
            }
            else if (!green.isHidden) {
                return UIColor.green
            }
            else {
                return UIColor.blue
            }
        }
        set(col) {
            if col != UIColor.red && col != UIColor.green && col != UIColor.blue {
                return
            }
            red.isHidden = col != UIColor.red
            green.isHidden = col != UIColor.green
            blue.isHidden = col != UIColor.blue
        }
    }
    
    var box: CGRect {
        get {
            return self.calculateAccumulatedFrame()
        }
    }
    
    func updateDelta(_ delta: TimeInterval){}
    
    func reset(){}
}
