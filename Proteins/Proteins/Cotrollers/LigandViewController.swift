//
//  LigandViewController.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/28.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import SceneKit

class LigandViewController: UIViewController {
    var ligand: String!
    
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var ligandName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let data = LigandModel()
    let cameraNode = SCNNode()
    var thisData: String?
    //Touch nodes
    var oldNode: SCNNode?
    var element: Element?
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    // Gestures
    var currentAngle: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        ligandName.text = ligand
        switch UIDevice.current.orientation {
        case .portrait:
            sceneSetup(orientation: "Portrait")
        case .landscapeLeft:
            sceneSetup(orientation: "Landscape")
        case .landscapeRight:
            sceneSetup(orientation: "Landscape")
        default:
            sceneSetup(orientation: "Landscape")
        }
        data.getModel(ligand: ligand, completionHandler: { (response) in
            DispatchQueue.main.async {
                if let _data = response {
                    self.ligandSelected(specs: _data)
                    self.thisData = _data
                } else {
                    print("nil")
                }
            }
        })
        self.element = GetElementDetails().getDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .portrait:
            sceneSetup(orientation: "Portrait")
            self.ligandSelected(specs: self.thisData!)
            break
        case .portraitUpsideDown:
            sceneSetup(orientation: "Portrait")
            self.ligandSelected(specs: self.thisData!)
            break
        case .landscapeLeft:
            sceneSetup(orientation: "Landscape")
            self.ligandSelected(specs: self.thisData!)
            break
        case .landscapeRight:
            sceneSetup(orientation: "Landscape")
            self.ligandSelected(specs: self.thisData!)
            break
        default:
            sceneSetup(orientation: "Landscape")
            self.ligandSelected(specs: self.thisData!)
        }
    }
    
    @IBAction func shareOnClick(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(sceneView.bounds.size, false, UIScreen.main.scale)
        sceneView.drawHierarchy(in: sceneView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    func sceneSetup(orientation: String) {
        cameraNode.removeFromParentNode()
        sceneView.scene = nil
        let scene = SCNScene()
        
        cameraNode.camera = SCNCamera()
        if orientation == "Portrait" {
            cameraNode.position = SCNVector3Make(0, 0, 30)
            scene.rootNode.addChildNode(cameraNode)
        } else {
            cameraNode.position = SCNVector3Make(0, 0, 20)
            scene.rootNode.addChildNode(cameraNode)
        }
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
    }
    
    func ligandSelected(specs: String) {
        geometryNode.removeFromParentNode()
        currentAngle = 0.0
        geometryNode = Molecules.drawLigand(specs: specs)
        sceneView.scene!.rootNode.addChildNode(geometryNode)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

}
