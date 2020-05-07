//
//  SearchViewNavigationBarTrailingItems.swift
//  Villa2
//
//  Created by nic Wanavit on 4/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct SearchViewNavigationBarTrailingItems: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var catList:ProductCategoryList
    @Binding var searchBar: Bool
//    init(){
//        UINavigationBar.appearance().height
//    }
    
    var body: some View {
        
        HStack{
//            SearchBar(text: self.$filter, showCat: self.$showCat, sidebar: self.$sidebar,disableImageAnimation: self.$disableImageAnimation, resultLimit: self.$resultLimit, isSearching: self.$isSearching)
//            .gesture(drag)
            
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack{
//                    ForEach(0...5, id: \.self){
//                        Text("\($0)")
//                    }
//                }
//            }
            Image(systemName: "magnifyingglass")
                .onTapGesture {
                    self.searchBar.toggle()
            }
            .padding()
            
            
            NavigationLink(destination:
                CartView()
                .environment(\.managedObjectContext, self.moc)
                , label: {
                    GoToCartButton(isCheckout: .constant(false), showModal: .constant(false))
            })
            
        }
    }
}

struct SearchViewNavigationBarTrailingItems_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewNavigationBarTrailingItems(searchBar: .constant(false))
    }
}
