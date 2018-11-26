//
//  ViewController.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/12.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import SceneKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var ligandName: UILabel!
    @IBOutlet weak var sceneView: SCNView!
    
    let data = LigandData()
    var thisData: String?
    //Touch nodes
    var oldNode: SCNNode?
    var element: Element?
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    // Gestures
    var currentAngle: Float = 0.0
    
    @IBAction func shareButton(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        print("ScreenShot")
//        let activityController = UIActivityViewController(activityItems: [elementName.text!], applicationActivities: nil)
//        present(activityController, animated: true, completion: nil)
    }
    
    func showAlert(service: String) {
    }
    
    func segmentValueChanged(info: String) {
        geometryNode.removeFromParentNode()
        currentAngle = 0.0
        geometryNode = Molecules.drawLigand(info: info)
        sceneView.scene!.rootNode.addChildNode(geometryNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementName.text = "Element"
        ligandName.text = "Ligand"
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
        data.getLigand(ligand: "001", completionHandler: { (response) in
            DispatchQueue.main.async {
                if let _data = response {
                    self.segmentValueChanged(info: _data)
                    self.thisData = _data
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
    
    let cameraNode = SCNNode()
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .portrait:
            sceneSetup(orientation: "Portrait")
            self.segmentValueChanged(info: self.thisData!)
            break
        case .portraitUpsideDown:
            sceneSetup(orientation: "Portrait")
            self.segmentValueChanged(info: self.thisData!)
            break
        case .landscapeLeft:
            sceneSetup(orientation: "Landscape")
            self.segmentValueChanged(info: self.thisData!)
            break
        case .landscapeRight:
            sceneSetup(orientation: "Landscape")
            self.segmentValueChanged(info: self.thisData!)
            break
        default:
            sceneSetup(orientation: "Landscape")
            self.segmentValueChanged(info: self.thisData!)
        }
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

}

