//
//  ContentView.swift
//  Gallery
//
//  Created by Gustavo Binder on 26/09/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    var scnScene : SCNScene = SCNScene(named: "map_2.scn")!
    var scnCamera : SCNNode = SCNNode()
    var renderDelegate : RenderDelegate = RenderDelegate()
    var mapManager : MapManager = MapManager()
    
    @StateObject var fpsCtr = FPSController()
    
    var body: some View {
        ZStack {
            
            SceneView(scene: scnScene, pointOfView: fpsCtr.getNode(), preferredFramesPerSecond: 60, delegate: renderDelegate)
                .onAppear {
                    scnScene.rootNode.addChildNode(fpsCtr.getNode())
//
//                    let poster = SCNNode(geometry: SCNPlane(width: 1, height: 1.2))
//                    let material = SCNMaterial()
//
//                    material.diffuse.contents = UIImage(named: "poster_1.jpg")
//
//                    poster.geometry?.firstMaterial = material
//                    poster.name = "Silence of The Lambs"
//
//                    poster.position = SCNVector3(x: 0, y: 0, z: -1.99)
//
//                    scnScene.rootNode.addChildNode(poster)
                    
                    mapManager.createMap(scene: scnScene, player: fpsCtr.getNode(), map: map)
                }
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    SpatialTapGesture(count: 1)
                        .onEnded({ event in
                            guard let renderer = renderDelegate.lastRenderer else { return }
                                let hits = renderer.hitTest(event.location, options: nil)
                                if let tappedNode = hits.first?.node {
                                    print("Hello")
                                }
                        })
                )
            VStack {
                HStack {
                    Spacer()
                    InGameButton(funcToExec: {
                        if fpsCtr.playerFrontEmpty(scnScene) {
                            let sphere = SCNNode(geometry: SCNPlane(width: 1, height: 1))
                            let playerPos = fpsCtr.getPosition()
                            let playerRot = fpsCtr.getRotation()
                            
                            sphere.position = playerPos
                            sphere.position.x -= sin(playerRot.y) * 1.95
                            sphere.position.z -= cos(playerRot.y) * 1.95
                            sphere.rotation = playerRot
                            
                            scnScene.rootNode.addChildNode(sphere)
                        }
                    }, image: "plus.app.fill")
                    .padding()
                }
                Spacer()
                HStack {
                    InGameButton(funcToExec: {
                        fpsCtr.forward(scnScene)
                    }, image: "arrow.up")
                    
                    Spacer()
                    
                    InGameButton(funcToExec: {
                        fpsCtr.rotate(.esquerda)
                    }, image: "arrow.turn.up.left")
                    
                    InGameButton(funcToExec: {
                        fpsCtr.rotate(.direita)
                    }, image: "arrow.turn.up.right")
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
