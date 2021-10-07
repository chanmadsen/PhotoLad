//
//  TabBarVC.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//

import UIKit
class TabBarVC: UITabBar {

    private var shapeLayer: CALayer?
    
    private func addShape() {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.opacity = 0.5
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = #colorLiteral(red: 0.7567946315, green: 0.7961222529, blue: 0.803817749, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.7568627451, green: 0.7960784314, blue: 0.8039215686, alpha: 1)
    }
    
    func createPath() -> CGPath {
        let path = UIBezierPath()
        
        
        path.move(to: CGPoint(x: 0, y: -15))
        path.addLine(to: CGPoint(x: self.frame.width, y: -15))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))//bottom left
        path.close()
        
        return path.cgPath
    }
}

