//
//  RainFall.swift
//  WeatherApp
//
//  Created by Johnny Tam on 20/3/2024.
//

import SpriteKit


class RainFall: SKScene{
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill
        
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        backgroundColor = .clear
        
        let node = SKEmitterNode(fileNamed: "RainFallEffect.sks")!
        addChild(node)
        
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        
        
    }
}
