//
//  ViewController.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/12.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var sceneView: SCNView!
    let data = LigandData()
    //Touch nodes
    var oldNode: SCNNode?
    var element: Element?
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    // Gestures
    var currentAngle: Float = 0.0
    
    func segmentValueChanged(info: String) {
        geometryNode.removeFromParentNode()
        currentAngle = 0.0
        geometryNode = Molecules.drawLigand(info: info)
        sceneView.scene!.rootNode.addChildNode(geometryNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementName.text = ""
        sceneSetup()
        data.getLigand(ligand: "001", completionHandler: { (response) in
            DispatchQueue.main.async {
                if let _data = response {
                    self.segmentValueChanged(info: _data)
                } else {
                    print("nil")
                }
            }
        })
        self.element = GetElementDetails().getDetails()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.oldNode?.removeAllActions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: sceneView)
        let hitList = sceneView.hitTest(location, options: nil)
        
        DispatchQueue.main.async {
            if let hitObject = hitList.first {
                if hitObject.node.name != "CONECT" && touches.count == 1 {
                    
                    self.oldNode?.removeAllActions()
                    for elem in (self.element?.elements)! {
                        if (elem.symbol?.lowercased() == hitObject.node.name?.lowercased()) {
                            self.elementName.text = elem.name
                        }
                    }
                }
            } else if (touches.count > 1) {
                self.oldNode?.removeAllActions()
            }
        }
    }
    
    func sceneSetup() {
        let scene = SCNScene()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 30)
        scene.rootNode.addChildNode(cameraNode)
        
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
    }

}

