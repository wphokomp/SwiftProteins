//
//  NobleAtom.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/19.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation
import SceneKit

class NobleAtom {
    class func nobleAtom() -> SCNGeometry {
        let noble = SCNSphere(radius: 0.50)
        noble.firstMaterial!.diffuse.contents = UIColor(displayP3Red: 0.00, green: 1.00, blue: 1.00, alpha: 1.0)
        noble.firstMaterial!.specular.contents = UIColor.white
        return noble
    }
}
