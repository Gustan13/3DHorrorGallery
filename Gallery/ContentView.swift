//
//  ContentView.swift
//  Gallery
//
//  Created by Gustavo Binder on 26/09/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    var scnScene : SCNScene = SCNScene(named: "map.scn")!
    var scnCamera : SCNNode = SCNNode()
    
    @State var angle : Float = 0.0
    
    var text = SCNNode(geometry: SCNText(string: "Hello", extrusionDepth: 2))
    
    init() {
        scnScene.rootNode.addChildNode(scnCamera)
        scnCamera.camera = SCNCamera()
    }
    
    var body: some View {
        VStack {
            
            SceneView(scene: scnScene, pointOfView: scnCamera)
                .onAppear {
                    scnScene.fogDensityExponent = CGFloat(1)
                    scnScene.fogStartDistance = CGFloat(5)
                    scnScene.fogEndDistance = CGFloat(8)
                    scnScene.fogColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
                    
                    scnCamera.light = SCNLight()
                    scnCamera.light?.type = .omni
                    scnCamera.light?.color = CGColor(red: 255, green: 100, blue: 100, alpha: 1)
                    scnCamera.light?.attenuationEndDistance = 20
                    
                    scnCamera.camera?.fieldOfView = 60
                    scnCamera.position = SCNVector3(x: 0, y: 0, z: 0)
                    
                    scnScene.rootNode.addChildNode(scnCamera)
                }
                .edgesIgnoringSafeArea(.all)
            HStack {
                Button {
                    print(scnCamera.rotation)
                    if angle >= Float.pi * 2 { angle = 0 }
                    let lastAngle = angle
                    angle += Float.pi/2
                    for i in 0...89 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(i * 2)) {
                            scnCamera.rotation = SCNQuaternion(x: 0, y: lastAngle + ((Float.pi/2) / 90) * Float(i), z: 0, w: lastAngle + ((Float.pi/2) / 90) * Float(i))
                        }
                    }
                } label: {
                    Text("Rotate Left")
                }
                
                Button {
                    print(cos(scnCamera.rotation.y))
                    for i in 0...15 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(i * 10)) {
                            scnCamera.localTranslate(by: SCNVector3(x: 0, y: 0, z: -1/4))
                        }
                    }
                } label: {
                    Text("Forward")
                }
                
                Button {
                    if angle <= 0.1 { angle = Float.pi*2 }
                    let lastAngle = angle
                    angle -= Float.pi/2
                    for i in 0...89 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(i * 2)) {
                            scnCamera.rotation = SCNQuaternion(x: 0, y: lastAngle - ((Float.pi/2) / 90) * Float(i), z: 0, w: lastAngle - ((Float.pi/2) / 90) * Float(i))
                        }
                    }
                } label: {
                    Text("Rotate Right")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
