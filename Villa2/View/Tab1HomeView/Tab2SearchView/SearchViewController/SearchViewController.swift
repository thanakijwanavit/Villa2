//
//  Tab2View.swift
//  Villa2
//
//  Created by nic Wanavit on 3/15/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData

struct SearchViewController: View {
//    @EnvironmentObject var user:CurrentUser
    @EnvironmentObject var catList:ProductCategoryList
    @State var sidebar:Bool = false
    @State var currentCat:Int = -1
    @State var currentSubCat:Int = 0
    @State var filter:String = ""
    @State var showCat:Bool = true
    @State var disableImageAnimation:Bool = false
    @State var resultLimit:Int = 40
    @State var isCheckout = false
    @State var isSearching = false
    @State var searchBar = false
    @Environment(\.managedObjectContext) var moc
//    @EnvironmentObject var showProductModal:ShowProductModal //= ShowProductModal()
    @State var cat1 = ""
    @State var cat2 = ""
    
    var subcat:[ProductCategory] {
        get {
            return self.currentCat == -1 ? self.mainCat[0].childrenData : self.mainCat[self.currentCat].childrenData
        }
    }
    var fetchRequest:FetchRequest<ProductCore>
    var productCores: FetchedResults<ProductCore>{
        fetchRequest.wrappedValue
    }
    
    init(){
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        request.fetchLimit = 20
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
    }
    
    init(mainCatID:Int, sideBar:Bool = true){
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        request.fetchLimit = 20
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
        self._currentCat = State(initialValue: mainCatID)
        self._sidebar = State(initialValue: sideBar)
    }
    
    
    
    var mainCat:[ProductCategory] { get {self.catList.products.childrenData[0].childrenData}}
    
    
    var body: some View {
        let drag = DragGesture(minimumDistance: 30, coordinateSpace: .global)
        .onChanged{
            self.dragValue(translation: $0.translation, sidebar: self.$sidebar, showCat: self.$showCat)
        }
        
        
        
        return GeometryReader{ g in
                VStack{
//                    if self.currentCat != -1 {
//                        MainCatSearchIcons(mainCat: self.mainCat, currentCat: self.$currentCat, currentSubCat: self.$currentSubCat, sidebar: self.$sidebar, resultLimit: self.$resultLimit )
//    //                        .offset(x: 0, y: -50)
//                            .animation(.easeInOut(duration: 1))
//                    }
                    
                    // show/hide search bar
                    if self.searchBar{
                        SearchBar(text: self.$filter, showCat: self.$showCat, sidebar: self.$sidebar,disableImageAnimation: self.$disableImageAnimation, resultLimit: self.$resultLimit, isSearching: self.$isSearching)
                            .gesture(drag)
                    }
                        
//                    if self.showCat{
//                        MainCatSearchIcons(mainCat: self.mainCat, currentCat: self.$currentCat, currentSubCat: self.$currentSubCat, sidebar: self.$sidebar, resultLimit: self.$resultLimit )
//                            .gesture(drag)
//                    }
//                    Spacer()
//                        .frame(width: g.size.width, height: 20, alignment: .center)
                    
                    ZStack(alignment: .leading) {
                        VStack(spacing: 10){
                            ZStack{
                                Color(UIColor.systemBackground)
                                
                                SearchViewProductTable(
                                    filter: self.filter,
                                    disableImageAnimation: self.$disableImageAnimation,
                                    resultLimit: self.resultLimit,
                                    bindingResultLimit: self.$resultLimit,
                                    sidebar: self.$sidebar,
                                    cat1: self.currentCat >= 0 ? self.mainCat[self.currentCat].id.string : "" ,
                                    cat2: self.currentSubCat == -1 ? "" : (self.currentSubCat < self.subcat.count) && (self.currentCat >= 0) ? self.subcat[self.currentSubCat].id.string : "", isSearching: self.$isSearching,
                                    width: self.productTableWidth(g: g)
                                    )
//                                .frame(width: self.productTableWidth(g: g) > 100 ? self.productTableWidth(g: g) : 100)
    //                                .environmentObject(self.showProductModal)
                            }
                        }
                        .frame(width: self.sidebar ? self.productTableWidth(g: g) : g.size.width)
//                        .frame(minWidth: 100, maxWidth: self.productTableWidth(g: g) > 100 ? self.productTableWidth(g: g):100 )
                        .offset(x: self.sidebar ? (self.sidebarWidth(g: g)) : 0)
                        
                            
                        
                        SideBarSearchIcons(mainCat: self.mainCat,currentCat: self.currentCat, currentSubCat: self.$currentSubCat, sideBarWidth: self.sidebarWidth(g: g))
                        .animation(self.disableImageAnimation ? nil:Animation.default)
                        .offset(x: !self.sidebar ? -self.sidebarWidth(g: g) : 0)
                        
                    }
                    .gesture(drag)
                    .animation(.easeInOut)
                    
                    
                    
                //NavigationBar Items
                    
                    .navigationBarTitle(Text(self.currentCat == -1 ? "All": self.mainCat[self.currentCat].name),displayMode: .large)
                    .navigationBarItems(leading:
                        SearchViewNavigationBarLeadingItems(currentCat: self.$currentCat, currentSubCat: self.$currentSubCat, sidebar: self.$sidebar, resultLimit: self.$resultLimit)

                      , trailing:
                        SearchViewNavigationBarTrailingItems(searchBar: self.$searchBar)
                    )
            }
        }
    }
}


struct FormSectionView_Previews: PreviewProvider {
//    let productCat:ProductCategoryList = ProductCategoryList(productCategory: SampleCategory.category)
    
    static var previews: some View {
        let productCat = ProductCategoryList(productCategory: SampleCategory.category)
        return Group {
            SearchViewController()
            .environment(\.colorScheme, .dark)
            
            SearchViewController()
            .environment(\.colorScheme, .light)

        }
        .environmentObject(productCat)
        .environmentObject(ShowProductModal())
        .environment(\.managedObjectContext, SampleProductCore.context)
        .background(Color(.systemBackground))
        .previewLayout(.sizeThatFits)
    }
}
