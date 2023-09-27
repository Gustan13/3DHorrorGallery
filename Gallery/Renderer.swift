//
//  Renderer.swift
//  Gallery
//
//  Created by Gustavo Binder on 27/09/23.
//

import SceneKit

class RenderDelegate : NSObject, SCNSceneRendererDelegate {
    
    var lastRenderer : SCNSceneRenderer!
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        lastRenderer = renderer
    }
}
