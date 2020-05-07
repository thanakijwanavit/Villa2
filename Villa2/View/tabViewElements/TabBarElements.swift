//
//  TabBarElements.swift
//  tabBarControllerDemo
//
//  Created by nic Wanavit on 3/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI

// 1
struct TabBarElementItem {
    var title: String
    var image: UIImage
    var badge: String?
}

// 2
protocol TabBarElementView: View {
    associatedtype Content
    
    var content: Content { get set }
    var tabBarElementItem: TabBarElementItem { get set }
}

struct TabBarElement: TabBarElementView {
    var tabBarElementItem: TabBarElementItem
    
    
    internal var content: AnyView
    
    init<Content: View>(tabBarElementItem: TabBarElementItem, // 3
    @ViewBuilder _ content: () -> Content) {
        self.tabBarElementItem = tabBarElementItem
        self.content = AnyView(content()) // 5

    }
    
    var body: some View {
        self.content
    }
}

struct TabBarElement_Previews: PreviewProvider {
    static var previews: some View {
        TabBarElement(tabBarElementItem: .init(
            title: "first",
            image: UIImage(systemName: "house.fill")!
            )
        ){
            Text("hello world")
        }
    }
}
