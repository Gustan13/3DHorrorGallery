//
//  Main.swift
//  Gallery
//
//  Created by Gustavo Binder on 29/09/23.
//

import SwiftUI
import SceneKit
import SpriteKit

struct Main: View {
    
    var scnScene : SCNScene = SCNScene(named: "map_2.scn")!
    var fpsCtr : FPSController = FPSController()
    var mapManager : MapManager = MapManager()
    
    @State var tab : Int = 0
    @State var canMakeMap : Bool = true
    
    var body: some View {
        VStack {
            if tab == 0 {
                Image("Title")
                Text("By Gustavo Isoo Binder")
                    .font(.footnote)
                    .padding(.bottom, 20)
                if !canMakeMap {
                    Button {
                        withAnimation(.smooth(duration: 2)) {
                            tab = 1
                        }
                    } label: {
                        Text("Explore")
                            .foregroundStyle(.red)
                    }
                }
                if !canMakeMap {
                    Button {
                        scnScene.rootNode.enumerateChildNodes { child, _ in
                            child.removeFromParentNode()
                        }
                        withAnimation {
                            canMakeMap = true
                        }
                    } label: {
                        Text("Change Hall")
                            .foregroundStyle(.white)
                    }
                } else {
                    Button {
                        scnScene.rootNode.addChildNode(fpsCtr.getNode())
                        mapManager.createMap(scene: scnScene, player: fpsCtr.getNode(), map: map)
                        withAnimation {
                            canMakeMap = false
                        }
                    } label: {
                        Text("Clover Hall")
                            .foregroundStyle(.white)
                            .frame(width: 125, height: 40)
                            .border(Color.white)
                    }
                    Button {
                        scnScene.rootNode.addChildNode(fpsCtr.getNode())
                        mapManager.createMap(scene: scnScene, player: fpsCtr.getNode(), map: map2)
                        withAnimation {
                            canMakeMap = false
                        }
                    } label: {
                        Text("Cross Hall")
                            .foregroundStyle(.white)
                            .frame(width: 125, height: 40)
                            .border(Color.white)
                    }
                    Button {
                        scnScene.rootNode.addChildNode(fpsCtr.getNode())
                        mapManager.createMap(scene: scnScene, player: fpsCtr.getNode(), map: map3)
                        withAnimation {
                            canMakeMap = false
                        }
                    } label: {
                        Text("Great Hall")
                            .foregroundStyle(.white)
                            .frame(width: 125, height: 40)
                            .border(Color.white)
                    }
                }

                
            } else if tab == 1 {
                ContentView(scnScene: scnScene, mapManager: mapManager, fpsCtr: fpsCtr, tab: $tab)
                    .transition(.opacity)
            } else if tab == 2 {
                Button {
                    withAnimation {
                        tab = 0
                    }
                } label: {
                    Text("Go Back")
                }
                .transition(.scale)
                SpriteView(scene: EditorView(map: map))
                    .scaledToFit()
            }
        }
        .preferredColorScheme(.dark)
    }
}
