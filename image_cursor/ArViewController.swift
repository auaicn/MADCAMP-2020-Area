//
//  ViewController.swift
//  MonaLisa
//
//  Created by Wooseong Kim on 2020/08/02.
//  Copyright © 2020 Wooseong Kim. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ArViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var grids = [Grid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = Grid(anchor: planeAnchor)
        self.grids.append(grid)
        node.addChildNode(grid)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = self.grids.filter { grid in
            return grid.anchor.identifier == planeAnchor.identifier
            }.first

        guard let foundGrid = grid else {
            return
        }

        foundGrid.update(anchor: planeAnchor)
    }
    
    @objc func tapped(gesture: UITapGestureRecognizer) {
        // Get 2D position of touch event on screen
        let touchPosition = gesture.location(in: sceneView)

        // Translate those 2D points to 3D points using hitTest (existing plane)
        let hitTestResults = sceneView.hitTest(touchPosition, types: .existingPlaneUsingExtent)

        // Get hitTest results and ensure that the hitTest corresponds to a grid that has been placed on a wall
        guard let hitTest = hitTestResults.first, let anchor = hitTest.anchor as? ARPlaneAnchor, let gridIndex = grids.index(where: { $0.anchor == anchor }) else {
            return
        }
        addPainting(hitTest, grids[gridIndex])
    }
    
    func addPainting(_ hitResult: ARHitTestResult, _ grid: Grid) {
        // 1.
        let planeGeometry = SCNPlane(width: 0.2, height: 0.35)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "mona-lisa")
        planeGeometry.materials = [material]

        // 2.
        let paintingNode = SCNNode(geometry: planeGeometry)
        paintingNode.transform = SCNMatrix4(hitResult.anchor!.transform)
        paintingNode.eulerAngles = SCNVector3(paintingNode.eulerAngles.x + (-Float.pi / 2), paintingNode.eulerAngles.y, paintingNode.eulerAngles.z)
        paintingNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(paintingNode)
        grid.removeFromParentNode()
    }

    // Gallery loading
    let picker = UIImagePickerController()
    
    @IBOutlet var imageView: [UIImageView]!
    @IBAction func addAction(_ sender: Any) {
           let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
           
           let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
           }
           
           let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
               self.openCamera()
           }
           
           let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
           
           alert.addAction(library)
           alert.addAction(camera)
           alert.addAction(cancel)
           present(alert, animated: true, completion: nil)
           
       }

       func openLibrary()
       {
           picker.sourceType = .photoLibrary
           present(picker, animated: false, completion: nil)

       }
       func openCamera()
       {
           if(UIImagePickerController .isSourceTypeAvailable(.camera)){
               picker.sourceType = .camera
               present(picker, animated: false, completion: nil)
           }
           else{
               print("Camera not available")
           }
       }
}

/*
// Image Picker Extension
extension ArViewController : UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // self.imageView.image = selectedImage

        picker.dismiss(animated: true, completion: nil)
    }

    func main(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
*/
