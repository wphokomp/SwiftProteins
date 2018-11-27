//
//  LigandModel.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/27.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation

class LigandModel {
    func getModel(ligand: String, completionHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://files.rcsb.org/ligands/view/\(ligand)_ideal.pdb") else {return}
        
        let task = URLSession.shared.downloadTask(with: url) {
            data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    if let pdbFile : String = try? String(contentsOf: data) {
                        completionHandler(pdbFile)
                    } else {
                        completionHandler(nil)
                    }
                }
            }
        }
        task.resume()
    }
}
