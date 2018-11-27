//
//  ElementInformation.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/27.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import Foundation
import UIKit

class GetElementDetails {
    func getDetails() -> Element? {
        var jsonPayload : Element? = nil
        if let path = Bundle.main.path(forResource: "PeriodicTableJSON", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                jsonPayload = try JSONDecoder().decode(Element.self, from: data)
                
                return jsonPayload
            } catch  {
//                ViewController().showAlert(title: "Error", message: "Cannot read from file")
            }
        }
        return jsonPayload
    }
}
