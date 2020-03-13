//
//  SceneDelegate.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
        
        let contentView = ContentView()
            .environment(\.window, window)
            .environment(\.managedObjectContext, context)
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))
            .environmentObject(CurrentUser())
            .environmentObject(PresentationStatus())


        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }



    func sceneDidEnterBackground(_ scene: UIScene) {

        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

