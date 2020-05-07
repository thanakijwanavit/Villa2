//
//  UITabBarWrapper.swift
//  tabBarControllerDemo
//
//  Created by nic Wanavit on 3/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct UITabBarWrapper: View {
    var controllers: [UIHostingController<TabBarElement>] // 1
    
    init(_ elements: [TabBarElement]) {
        self.controllers = elements.enumerated().map { // 2
            let hostingController = UIHostingController(rootView: $1)
                        
            let tabBarItem = UITabBarItem( // 3
                            title: $1.tabBarElementItem.title,
            //                image: UIImage.init(systemName: $1.tabBarElementItem.systemImageName),
                            image:  $1.tabBarElementItem.image,
                            tag: $0 // 4
                        )
            if let badgeValue = $1.tabBarElementItem.badge{
                tabBarItem.badgeValue = badgeValue
            }
            
            hostingController.tabBarItem = tabBarItem
            
            
            return hostingController
        }
    }
    
    var body: some View {
        UITabBarControllerWrapper(viewControllers: self.controllers) // 5
    }
}

struct UITabBarWrapper_Previews: PreviewProvider {
    static var previews: some View {
        UITabBarWrapper([
            TabBarElement(tabBarElementItem:
            TabBarElementItem(title: "Test 1", image: UIImage(systemName: "house.fill")!)) {
                    Text("Test 1 Text")
            }
        ])
    }
}
