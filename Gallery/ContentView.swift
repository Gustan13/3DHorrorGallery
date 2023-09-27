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
    var renderDelegate : RenderDelegate = RenderDelegate()
    
    @StateObject var fpsCtr = FPSController()
    
    var body: some View {
        ZStack {
            
            SceneView(scene: scnScene, pointOfView: fpsCtr.getNode(), preferredFramesPerSecond: 60, delegate: renderDelegate)
                .onAppear {
                    scnScene.fogDensityExponent = CGFloat(1)
                    scnScene.fogStartDistance = CGFloat(5)
                    scnScene.fogEndDistance = CGFloat(8)
                    scnScene.fogColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
                    
                    fpsCtr.getNode().light = SCNLight()
                    fpsCtr.getNode().light?.type = .omni
                    fpsCtr.getNode().light?.color = UIColor.gray
                    fpsCtr.getNode().light?.attenuationEndDistance = 15
                    
                    fpsCtr.getNode().camera?.fieldOfView = 60
                    fpsCtr.setPosition(SCNVector3(x: 0, y: 0, z: 0))
                    
                    scnScene.rootNode.addChildNode(fpsCtr.getNode())
                    
                    let poster = SCNNode(geometry: SCNPlane(width: 1, height: 1.2))
                    let material = SCNMaterial()
                    
                    material.diffuse.contents = UIImage(named: "poster_1.jpg")
                    
                    scnScene.background.contents = UIColor.black
                    
                    poster.geometry?.firstMaterial = material
                    poster.name = "Silence of The Lambs"
                    
                    poster.position = SCNVector3(x: 0, y: 0, z: -1.99)
                    
                    poster.castsShadow = true
                    
                    scnScene.rootNode.addChildNode(poster)
                }
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    SpatialTapGesture(count: 1)
                        .onEnded({ event in
                            guard let renderer = renderDelegate.lastRenderer else { return }
                                let hits = renderer.hitTest(event.location, options: nil)
                                if let tappedNode = hits.first?.node {
                                    print("Hello")
                                    print(tappedNode.name ?? "Wierd")
                                }
                        })
                )
            VStack {
                Spacer()
                HStack {
                    Button {
                        fpsCtr.rotate(.esquerda)
                    } label: {
                        Text("Rotate Left")
                            .padding()
                            .background {
                                Color.black
                            }
                            .cornerRadius(8)
                    }
                    
                    Button {
                        fpsCtr.forward(scnScene)
                    } label: {
                        Text("Forward")
                            .padding()
                            .background {
                                Color.black
                            }
                            .cornerRadius(8)
                    }
                    Button {
                        fpsCtr.rotate(.direita)
                    } label: {
                        Text("Rotate Right")
                            .padding()
                            .background {
                                Color.black
                            }
                            .cornerRadius(8)

                    }
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
