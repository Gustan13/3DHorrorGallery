//
//  MovementManager.swift
//  Gallery
//
//  Created by Gustavo Binder on 26/09/23.
//

import SceneKit
import SwiftUI

public enum Direction : Int {
    case esquerda = 1
    case direita = -1
}

class FPSController : ObservableObject {
    
    @Published private var playerNode : SCNNode = SCNNode()
    @Published private var angle : Float = Float.pi/2
    @Published private var canMove : Bool = true
    
    init() {
        playerNode.camera = SCNCamera()
        playerNode.rotation = SCNQuaternion(x: 0, y: angle, z: 0, w: angle)
        
        playerNode.light = SCNLight()
        playerNode.light?.type = .omni
        playerNode.light?.color = UIColor.white
        playerNode.light?.attenuationEndDistance = 15
        playerNode.light?.intensity = 100
        
        playerNode.camera?.fieldOfView = 65
        self.setPosition(SCNVector3(x: 0, y: 0, z: 0))
    }
    
    public func setAngle(_ angle: Float) { self.angle = angle }
    public func setPosition(_ pos: SCNVector3) { self.playerNode.position = pos }
    public func setRotation(_ rot: SCNQuaternion) { self.playerNode.rotation = rot }
    
    public func getAngle() -> Float { return self.angle }
    public func getPosition() -> SCNVector3 { return self.playerNode.position }
    public func getRotation() -> SCNQuaternion { return self.playerNode.rotation }
    public func getNode() -> SCNNode { return self.playerNode }
    public func getMoveStatus() -> Bool { return self.canMove }
    
    public func rotate(_ dir: Direction) {
        
        if !canMove { return }
        
        var lastAngle = angle
        
        angle += (Float.pi/2) * Float(dir.rawValue)
        
        if angle >= Float.pi * 2 {
            angle = angle.remainder(dividingBy: Float.pi * 2)
        } else if angle < 0 {
            lastAngle = Float.pi * 2
            angle = Float.pi * 2 - Float.pi/2
        }
        
        canMove = false
        
        for i in 0...89 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(i * 4)) {
                self.playerNode.rotation = SCNQuaternion(x: 0, y: lastAngle + ((Float.pi/2) / 90) * Float(i * dir.rawValue), z: 0, w: lastAngle + ((Float.pi/2) / 90) * Float(i * dir.rawValue))
                if i == 89 {
                    self.setRotation(SCNQuaternion(x: 0, y: self.angle, z: 0, w: self.angle))
                    self.canMove = true
                }
            }
        }
    }
    
    public func forward(_ scene: SCNScene) {
        
        if !canMove { return }
        if playerFrontEmpty(scene) { return }
        
        canMove = false
        
        for i in 0...15 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(i * 30)) {
                self.playerNode.localTranslate(by: SCNVector3(x: 0, y: 0, z: -1/4))
                
                if i == 15 {
                    self.canMove = true
                }
            }
        }
    }
    
    public func playerFrontEmpty(_ scene: SCNScene) -> Bool {
        var nextPosition = playerNode.position
        
        nextPosition.x += sin(playerNode.rotation.y) * -4
        nextPosition.z += cos(playerNode.rotation.y) * -4
        
        nextPosition.x = round(nextPosition.x)
        nextPosition.z = round(nextPosition.z)
        
        let obstacle = scene.rootNode.childNodes { node, _ in
            
            let distance_x = floor(abs(nextPosition.x - node.position.x))
            let distance_z = floor(abs(nextPosition.z - node.position.z))
            
            if distance_x <= 0.5 && distance_z <= 0.5 {
                return true
            }
            return false
        }
        
        if obstacle.isEmpty {
            return true
        }
        return false
    }
    
    public func paintingInFront(_ scene: SCNScene) -> [SCNNode] {
        var nextPosition = playerNode.position
        
        nextPosition.x += sin(playerNode.rotation.y) * -1.95
        nextPosition.z += cos(playerNode.rotation.y) * -1.95
        
        nextPosition.x = round(nextPosition.x)
        nextPosition.z = round(nextPosition.z)
        
        let obstacle = scene.rootNode.childNodes { node, _ in
            
            let distance_x = floor(abs(nextPosition.x - node.position.x))
            let distance_z = floor(abs(nextPosition.z - node.position.z))
            
            if distance_x <= 0.5 && distance_z <= 0.5 {
                return true
            }
            return false
        }
        
        return obstacle
    }
}
