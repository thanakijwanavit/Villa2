//
//  Tab2View.swift
//  Villa2
//
//  Created by nic Wanavit on 3/15/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData

struct SearchViewNavigationController: View {
    
    
    
    
    var body: some View {
        
        return
            NavigationView{
                SearchViewController()
                    
            .onTapGesture {
                UIApplication.shared.endEditing()
                }
            
            }
    }
    
}



struct SearchViewNavigationController_Previews: PreviewProvider {
//    let productCat = ProductCategoryList(productCategory: SampleCategory.category)
    static var previews: some View {
        
        Group {
            NavigationView{
            SearchViewController()
            }
            .environment(\.colorScheme, .dark)
            NavigationView{
            SearchViewController()
            }
            .environment(\.colorScheme, .light)

        }
        .environmentObject(ProductCategoryList(productCategory: SampleCategory.category))
        .environmentObject(ShowProductModal())
        .environment(\.managedObjectContext, SampleProductCore.context)
        .background(Color(.systemBackground))
        .previewLayout(.sizeThatFits)
    }
}


extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.95)
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 30)]

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.90)
        standardAppearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 30)]
        
        // update the appearance

        navigationBar.standardAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = standardAppearance
        navigationBar.compactAppearance = appearance
    }
}
