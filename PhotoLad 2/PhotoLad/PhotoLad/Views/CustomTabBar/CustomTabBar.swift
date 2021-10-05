//
//  CustomTabBar.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/30/21.
//

import Foundation
import UIKit

class CustomTabBar: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 1
        setupMiddleButton()
        overrideUserInterfaceStyle = .light
        tabBar.barTintColor = UIColor.clear

    }
    
    func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 32.5, y: -10, width: 65, height: 65))
        
        middleButton.setBackgroundImage(UIImage(named: "HomeButton"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.4
        middleButton.layer.shadowOffset = CGSize(width: 7, height: 6)
        
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
}// End of class
