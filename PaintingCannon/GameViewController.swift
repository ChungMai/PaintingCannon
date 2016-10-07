//
//  GameViewController.swift
//  PaintingCannon
//
//  Created by Home on 8/4/16.
//  Copyright (c) 2016 Home. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = true
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        
        var viewSize = skView.bounds.size
        if UIDevice.current.userInterfaceIdiom == .phone {
            viewSize.height *= 2
            viewSize.width *= 2
        }
        
        let scene = GameScene(size: viewSize)
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}
