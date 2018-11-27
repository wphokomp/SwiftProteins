//
//  Bond.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/27.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation
import SceneKit


class Bond: SCNNode {
    
    init(vector1: SCNVector3, vector2: SCNVector3) {
        super.init()
        let parentNode = SCNNode()
        let height = length(vector1: vector1, vector2: vector2)
        
        self.position = vector1
        let node = SCNNode()
        node.position = vector2
        parentNode.addChildNode(node)
        
        let overLay = SCNNode()
        overLay.eulerAngles.x = Float(Double.pi / 2)
        
        let cylinder = SCNCylinder(radius: 0.1, height: CGFloat(height))
        cylinder.firstMaterial?.diffuse.contents = UIColor.white
        
        let cylinderNode = SCNNode(geometry: cylinder)
        cylinderNode.position.y = -height / 2
        overLay.addChildNode(cylinderNode)
        
        self.addChildNode(overLay)
        self.constraints = [SCNLookAtConstraint(target: node)]
    }
    
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder) has not been implemented")
    }
    
    func length(vector1: SCNVector3, vector2: SCNVector3) -> Float {
        let x = vector2.x - vector1.x
        let y = vector2.y - vector1.y
        let z = vector2.z - vector1.z
        let length = Float(sqrt(x * x + y * y + z * z))
        
        if length < 0 {
            return (length * -1)
        } else {
            return (length)
        }
    }
}
