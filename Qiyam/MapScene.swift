//
//  MapScene.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//
import SpriteKit

class MapScene: SKScene {
    let mapNode = SKSpriteNode(imageNamed: "allLevelsBackground")
    let cameraNode = SKCameraNode()
    
    // ✅ كولباك نستخدمه عشان نبلغ SwiftUI بأي مستوى يتم اختياره
    var onLevelSelected: ((Int) -> Void)?

    override func didMove(to view: SKView) {
        mapNode.position = CGPoint(x: size.width / 20, y: size.height / 14)
        mapNode.zPosition = 0
        mapNode.size = size
        addChild(mapNode)

        camera = cameraNode
        addChild(cameraNode)

        // ✅ أزرار المستويات (موزّعين على الغرف)
        addLevelButton(level: 1, position: CGPoint(x: size.width / 12, y: size.height * 12))
        addLevelButton(level: 2, position: CGPoint(x: size.width * 0.3, y: size.height * 2))
        addLevelButton(level: 3, position: CGPoint(x: size.width / 2, y: size.height * 0.6))
        addLevelButton(level: 4, position: CGPoint(x: size.width / 2, y: size.height * 0.8))
        // كمّلي لباقي المستويات بنفس الطريقة

        addLevelButton(level: 5, position: CGPoint(x: size.width * 0.5, y: size.height * 0.47))
        addLevelButton(level: 6, position: CGPoint(x: size.width * 0.5, y: size.height * 0.36))
        addLevelButton(level: 7, position: CGPoint(x: size.width * 22, y: size.height * 14))
        addLevelButton(level: 8, position: CGPoint(x: size.width * 12, y: size.height * 12))
    }

    func addLevelButton(level: Int, position: CGPoint) {
        let button = SKSpriteNode(color: .green, size: CGSize(width: 200, height: 100)) // ✅ مؤقتاً لون أخضر عشان تتأكدين
        button.position = position
        button.name = "level_\(level)"
        addChild(button)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("🔍 touchesBegan detected!") // عشان تتأكدين إذا لمس يشتغل
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        
        for node in nodesAtPoint {
            if let name = node.name, name.starts(with: "level_") {
                if let level = Int(name.replacingOccurrences(of: "level_", with: "")) {
                    print("✅ Level \(level) tapped!")
                    onLevelSelected?(level)
                }
            }
        }
    }
}
