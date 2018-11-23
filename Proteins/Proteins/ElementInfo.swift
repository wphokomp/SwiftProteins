//
//  ElementInfo.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/22.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation

struct Element : Decodable {
    let elements: [ElementDetail]?
}

struct ElementDetail : Decodable {
    let name : String?
    let symbol : String?
}


class GetElementDetails{
    func getDetails() -> Element? {
        var jsonPayload : Element? = nil
        
        if let path = Bundle.main.path(forResource: "PeriodicTableJSON", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                jsonPayload = try JSONDecoder().decode(Element.self, from: data) as Element?
                
                return jsonPayload
            } catch {
                print("Error getting element data")
            }
        }
        return jsonPayload
    }
}
