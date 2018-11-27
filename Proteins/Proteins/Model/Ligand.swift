//
//  Ligand.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/27.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation

class Ligand {
    let name : String
    let category : LigandType
//    let image : String
    
    init(_name: String, _category: LigandType/*, image: String*/) {
        name = _name
        category = _category
    }
}
