//
//  ViewController.swift
//  ARTest
//
//  Created by Joshua Auriemma on 9/13/17.
//  Copyright © 2017 Joshua Auriemma. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    let locationManager = CLLocationManager()
    let serialQueue = DispatchQueue(label: "com.apple.arkitexample.serialSceneKitQueue")
    let standardConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        return configuration
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.setup()
        sceneView.showsStatistics = true
        sceneView.scene.enableEnvironmentMapWithIntensity(25, queue: serialQueue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(standardConfiguration, options: [.resetTracking, .removeExistingAnchors])
        addSupermanModeltoScene()
    }
    
    func startMonitoringItem(_ beacon: Beacon) {
        let beaconRegion = beacon.asBeaconRegion()
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func stopMonitoringItem(_ beacon: Beacon) {
        let beaconRegion = beacon.asBeaconRegion()
        locationManager.stopMonitoring(for: beaconRegion)
        locationManager.stopRangingBeacons(in: beaconRegion)
    }

    func addSupermanBeacon() {
        let uuid = UUID(uuidString: "191744BF-A1F0-49DD-A489-2DFE89E6C3A3")!
        let beacon1 = Beacon(name: "AR Beacon 0", icon: 1, uuid: uuid, majorValue: CLBeaconMajorValue(0), minorValue: CLBeaconMinorValue(0))
        startMonitoringItem(beacon1)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func addSupermanModeltoScene() {
        let scene = SCNScene(named: "art.scnassets/superman.dae")!
        sceneView.scene = scene
    }
    
}

extension ViewController: ARSCNViewDelegate {
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("found!")
        if let beacon1 = beacons.first {
            if beacon1.accuracy != -1 && beacon1.accuracy < 3 {
                addSupermanModeltoScene()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print(#function)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print(#function)
    }
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
    
}
