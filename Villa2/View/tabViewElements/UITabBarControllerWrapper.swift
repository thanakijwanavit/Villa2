//
//  UITabBarControllerWrapper.swift
//  tabBarControllerDemo
//
//  Created by nic Wanavit on 3/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI

// 1
struct UITabBarControllerWrapper: UIViewControllerRepresentable {
    var viewControllers: [UIViewController]
    
    // 2
    func makeUIViewController(context: UIViewControllerRepresentableContext<UITabBarControllerWrapper>) -> UITabBarController {
        let tabBar = UITabBarController()
        
        // Configure Tab Bar here, if needed
        return tabBar
    }
    
    // 3
    func updateUIViewController(_ uiViewController: UITabBarController, context: UIViewControllerRepresentableContext<UITabBarControllerWrapper>) {
        uiViewController.setViewControllers(self.viewControllers, animated: false)
    }
    
    // 4
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: UITabBarControllerWrapper
        
        init(_ controller: UITabBarControllerWrapper) {
            self.parent = controller
        }
    }
}


