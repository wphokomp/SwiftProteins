//
//  Molecule.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/27.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation
import SceneKit
import UIKit

class Molecules {
    //ON CALL, DRAWS A LIGAND ON THE SCNView
    //RETURNS A NODE THAT WILL BE ADDED AS A CHILD ONTO THE SCENE
    class func drawLigand(specs: String) -> SCNNode {
        let molecule = SCNNode()
        var atoms: [SCNNode?] = []
        let protein = specs.split(separator: "\n")
        
        for line in protein {
            let detail = line.split(separator: " ")
            if detail[0] == "ATOM" {
                let atom = nodeWithAtom(atom: Atom.atom(element: String(detail[11])), molecule: molecule, position: SCNVector3Make(Float(detail[6])!, Float(detail[7])!, Float(detail[8])!))
                atom.position = SCNVector3(Double(detail[6])!, Double(detail[7])!, Double(detail[8])!)
                molecule.name = String(detail[11])
                atom.name = String(detail[11])
                atoms.append(atom)
            } else if detail[0] == "CONECT" {
                var i: Int = 0

                let range = atoms.count
                let parentAtom: Int = Int(detail[1])! - 1
                for element in detail {
                    let childAtom = (Int(element) ?? 0) - 1
                    if i > 1 {
                        if (parentAtom < range && childAtom < range) {
                            let bond = Bond(vector1: (atoms[parentAtom]?.position)!, vector2: (atoms[Int(element)! - 1]?.position)!)
                            bond.name = "CONECT"
                            molecule.addChildNode(bond)
                        }
                    }
                    i += 1
                }
            }
        }
        return molecule
    }
    
    //DRAWS AN ATOM WITH A SPECIFIC SCENE_GEOMETRY AND POSITION
    //DOES NOT WORK WITH BONDS BECAUSE THEY HAVE A 2D POSITIONING AND ELEMENTS USE 3D (SCNVector3Make(...))
    class func nodeWithAtom(atom: SCNGeometry, molecule: SCNNode, position: SCNVector3) -> SCNNode {
        let node = SCNNode(geometry: atom)
        node.position = position
        molecule.addChildNode(node)
        return node
    }
}
