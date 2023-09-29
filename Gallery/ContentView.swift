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
    @StateObject var viewModel = ProfileModel()
    
    var body: some View {
        ZStack {
            SceneView(scene: scnScene, pointOfView: fpsCtr.getNode(), preferredFramesPerSecond: 60, delegate: renderDelegate)
                .onAppear {
                    scnScene.rootNode.addChildNode(fpsCtr.getNode())
                    
                    mapManager.createMap(scene: scnScene, player: fpsCtr.getNode(), map: map)
                }
                .edgesIgnoringSafeArea(.all)
//                .gesture(
//                    SpatialTapGesture(count: 1)
//                        .onEnded({ event in
//                            guard let renderer = renderDelegate.lastRenderer else { return }
//                                let hits = renderer.hitTest(event.location, options: nil)
//                                if let tappedNode = hits.first?.node {
//                                    print("Hello")
//                                }
//                        })
//                )
            VStack {
                HStack {
                    Spacer()
                    EditableCircularProfileImage(viewModel: viewModel)
                    InGameButton(funcToExec: {
                        
                        if !fpsCtr.getMoveStatus() { return }
                        
                        var image : UIImage = UIImage(systemName: "exclamationmark.triangle")!
                        
                        switch (viewModel.imageState) {
                        case .empty:
                            return
                        case .loading(_):
                            return
                        case .success(let img):
                            image = img
                        case .failure(_):
                            return
                        }
                        
                        if fpsCtr.playerFrontEmpty(scnScene) {
                            let sphere = SCNNode(geometry: SCNPlane(width: 1, height: 1))
                            let framen = SCNScene(named: "frame_2.scn")!.rootNode
//                            let framen = SCNNode(geometry: SCNSphere(radius: 1))
                            
                            let playerPos = fpsCtr.getPosition()
                            let playerRot = fpsCtr.getRotation()
                            let imageMaterial = SCNMaterial()
                            
                            let pW = image.size.width
                            let pH = image.size.height
                            
                            framen.addChildNode(sphere)
                            
                            framen.position = playerPos
                            framen.position.x -= sin(playerRot.y) * 1.99
                            framen.position.z -= cos(playerRot.y) * 1.99
                            framen.rotation = playerRot
                            
                            imageMaterial.diffuse.contents = image
                            sphere.geometry?.materials = [imageMaterial]
                            
                            let sml = pW < pH ? (pW) : (pH)
//                            let big = pW > pH ? (pW) : (pH)
                            
//                            sphere.scale.x = Float(pW / sml)
//                            sphere.scale.y = Float(pH / sml)
                            
                            framen.scale.x = Float(pW / sml)
                            framen.scale.y = Float(pH / sml)
                            
                            scnScene.rootNode.addChildNode(framen)
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
