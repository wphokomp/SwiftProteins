//
//  File.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/19.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation
import SceneKit

class Atom {
    
    class func atom(element: String) -> SCNGeometry {
        let atom = SCNSphere(radius: 0.5)
        atom.firstMaterial!.diffuse.contents = self.CPKColor(element: element)
        atom.firstMaterial!.specular.contents = UIColor.white
        return atom
    }
    
    class func hydrogetAtom() -> SCNGeometry {
        let hydrogenAtom = SCNSphere(radius: 1.20)
        hydrogenAtom.firstMaterial!.diffuse.contents = UIColor.lightGray
        hydrogenAtom.firstMaterial!.specular.contents = UIColor.white
        return hydrogenAtom
    }
    
    class func CPKColor(element: String) -> UIColor {
        if element.uppercased() == "H" {
            return UIColor.white
        } else if element.uppercased() == "C" {
            return UIColor.black
        } else if element.uppercased() == "N" {
            return UIColor(displayP3Red: 0.00, green: 0.00, blue: 0.55, alpha: 1.0)
        } else if element.uppercased() == "O" {
            return UIColor.red
        } else if element.uppercased() == "F" || element.uppercased() == "CL" {
            return UIColor.green
        } else if element.uppercased() == "BR" {
            return UIColor(displayP3Red: 0.55, green: 0.00, blue: 0.00, alpha: 1.0)
        } else if element.uppercased() == "I" {
            return UIColor(displayP3Red: 0.58, green: 0.00, blue: 0.83, alpha: 1.0)
        } else if element.uppercased() == "HE" || element.uppercased() == "NE" || element.uppercased() == "AR"
            || element.uppercased() == "XE" || element.uppercased() == "KR" {
            return UIColor(displayP3Red: 0.00, green: 1.00, blue: 1.00, alpha: 1.0)
        } else if element.uppercased() == "P" {
            return UIColor.orange
        } else if element.uppercased() == "S" {
            return UIColor.yellow
        } else if element.uppercased() == "B" {
            return UIColor(displayP3Red: 1.00, green: 0.80, blue: 0.64, alpha: 1.0)
        } else if element.uppercased() == "LI" || element.uppercased() == "NA" || element.uppercased() == "K"
            || element.uppercased() == "RB" || element.uppercased() == "CS" || element.uppercased() == "FR"{
            return UIColor(displayP3Red: 0.58, green: 0.00, blue: 0.83, alpha: 1.0)
        } else if element.uppercased() == "BE" || element.uppercased() == "MG" || element.uppercased() == "CA"
            || element.uppercased() == "SR" || element.uppercased() == "BA" || element.uppercased() == "RA" {
            return UIColor(displayP3Red: 0.00, green: 0.39, blue: 00.00, alpha: 1.0)
        } else if element.uppercased() == "TI" {
            return UIColor.gray
        } else if element.uppercased() == "FE" {
            return UIColor(displayP3Red: 1.0, green: 0.55, blue: 0.00, alpha: 1.0)
        } else {
            return UIColor(displayP3Red: 1.00, green: 0.75, blue: 0.80, alpha: 1.0)
        }
    }
}
