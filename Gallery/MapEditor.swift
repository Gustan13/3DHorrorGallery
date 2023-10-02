//
//  MapEditor.swift
//  Gallery
//
//  Created by Gustavo Binder on 29/09/23.
//

import SpriteKit

enum TileStatus : Int {
    case empty = 0
    case hall = 1
    case player = 2
}

class Tile : SKSpriteNode {
    
    var current_status : TileStatus
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            
        }
    }
    
    init(current_status: TileStatus) {
        self.current_status = current_status
        var color : UIColor!
        
        switch (current_status) {
        case .empty:
            color = .red
        case .hall:
            color = .green
        case .player:
            color = .yellow
        }
        
        super.init(texture: nil, color: color, size: CGSize(width: 10, height: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch (current_status) {
        case .empty:
            current_status = .hall
            self.color = .green
        case .hall:
            current_status = .player
            self.color = .yellow
        case .player:
            current_status = .empty
            self.color = .red
        }
    }
}

class EditorView : SKScene {
    
    var map : [[Int]]
    var mapNodes : [SKNode] = []
    
    init(map: [[Int]]) {
        self.map = map
        super.init(size: CGSize(width: 80, height: 80))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        print("Begin")
        for row in 0...(map.count - 1) {
            for col in 0...(map[0].count - 1) {
                let status = {
                    switch (self.map[row][col]) {
                    case 0:
                        return TileStatus.empty
                    case 1:
                        return TileStatus.hall
                    case 2:
                        return TileStatus.player
                    default:
                        return TileStatus.empty
                    }
                }
                
                let sprite = Tile(current_status: status())
                
                sprite.position = CGPoint(x: 10 * Double(col) + 5, y: 10 * Double(row) + 5)
                
                sprite.zPosition = 5
                
                addChild(sprite)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
//        print("update")
    }
}
