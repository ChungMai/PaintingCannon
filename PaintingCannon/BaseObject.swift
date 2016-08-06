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
            if (!red.hidden) {
                return UIColor.redColor()
            }
            else if (!green.hidden) {
                return UIColor.greenColor()
            }
            else {
                return UIColor.blueColor()
            }
        }
        set(col) {
            if col != UIColor.redColor() && col != UIColor.greenColor() && col != UIColor.blueColor() {
                return
            }
            red.hidden = col != UIColor.redColor()
            green.hidden = col != UIColor.greenColor()
            blue.hidden = col != UIColor.blueColor()
        }
    }
    
    var box: CGRect {
        get {
            return self.calculateAccumulatedFrame()
        }
    }
    
    func updateDelta(delta: NSTimeInterval){}
    
    func reset(){}
}