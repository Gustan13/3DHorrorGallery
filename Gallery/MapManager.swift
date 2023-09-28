//
//  MapManager.swift
//  Gallery
//
//  Created by Gustavo Binder on 27/09/23.
//

let map : [[Int]] = [
    [1, 1, 1, 0, 1, 1],
    [1, 0, 1, 1, 0, 1],
    [2, 1, 0, 1, 1, 1]
]

import SceneKit

public enum wall_direction {
    case up, left, down, right
}

class MapManager {
    
    public func createMap(scene: SCNScene, player: SCNNode, map: [[Int]]) {
        
        let l1 = map.count - 1
        let l2 = map[0].count - 1
        
        for row in 0...l1 {
            for col in 0...l2 {
                
                if map[row][col] < 1 { continue }
                
                if map[row][col] == 2 {
                    player.position = SCNVector3(x: Float(row * 4), y: 0, z: Float(col * -4))
                }
                
                let room = SCNScene(named: "quart.scn")
                room!.rootNode.position = SCNVector3(x: Float(row * 4), y: 0, z: Float(col * -4))
                scene.rootNode.addChildNode(room!.rootNode)
                
                if row - 1 < 0 || map[row - 1][col] == 0 {
                    addWall(scene, SCNVector3(x: Float(row * 4), y: 0, z: Float(col * -4)), .up)
                }
                if row + 1 > l1 || map[row + 1][col] == 0 {
                    addWall(scene, SCNVector3(x: Float(row * 4), y: 0, z: Float(col * -4)), .down)
                }
                if col + 1 > l2 || map[row][col + 1] == 0 {
                    addWall(scene, SCNVector3(x: Float(row * 4), y: 0, z: Float(col * -4)), .right)
                }
                if col - 1 < 0 || map[row][col - 1] == 0 {
                    addWall(scene, SCNVector3(x: Float(row * 4), y: 0, z: Float(col * -4)), .left)
                }
            }
        }
    }
    
    private func addWall(_ scene: SCNScene, _ pos: SCNVector3, _ rot: wall_direction) {
        let wall = SCNScene(named: "wall.scn")
        
        scene.rootNode.addChildNode(wall!.rootNode)
        wall!.rootNode.position = pos
        
        switch (rot) {
        case .up:
            wall?.rootNode.rotation = SCNQuaternion(x: 0, y: Float.pi/2, z: 0, w: Float.pi/2)
        case .left:
            wall?.rootNode.rotation = SCNQuaternion(x: 0, y: Float.pi, z: 0, w: Float.pi)
        case .down:
            wall?.rootNode.rotation = SCNQuaternion(x: 0, y: 3 * Float.pi/2, z: 0, w: 3 * Float.pi/2)
        case .right:
            break
        }
    }
    
}
