//
//  Molecules.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/19.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation
import SceneKit
//0         1  2   3   4   5       6       7       8      9    10              11
//ATOM      1  PG  ATP A   1       1.200  -0.226  -6.850  1.00 10.00           P
class Molecules {
    class func drawLigand(info: String) -> SCNNode {
        var atoms: [SCNNode?] = []
        let molecule = SCNNode()
        let protein = info.split(separator: "\n")
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
    
    class func nodeWithAtom(atom: SCNGeometry, molecule: SCNNode, position: SCNVector3) -> SCNNode {
        let node = SCNNode(geometry: atom)
        node.position = position
        molecule.addChildNode(node)
        return node
    }
}
