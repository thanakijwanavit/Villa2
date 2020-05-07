//
//  FormSectionProductTable.swift
//  Villa2
//
//  Created by nic Wanavit on 3/15/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData
import KingfisherSwiftUI
struct SearchViewProductTable: View {
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry
    @Binding var disableImageAnimation:Bool
    @Binding var bindingResultLimit:Int
    @Binding var sidebar:Bool
    @Binding var isSearching:Bool
    var searchBarEmpty:Bool
    var fetchRequest:FetchRequest<ProductCore>
    var productCores: FetchedResults<ProductCore>{
        fetchRequest.wrappedValue
    }
    var width: CGFloat
    
    //var for the more button

    let filter:String
    let resultLimit:Int
    let cat1:String
    let cat2:String
    
    
    init(filter: String, disableImageAnimation:Binding<Bool>, resultLimit: Int, bindingResultLimit: Binding<Int>, sidebar: Binding<Bool>, cat1:String, cat2:String, isSearching:Binding<Bool>, width: CGFloat){
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        request.fetchLimit = resultLimit
//        debugPrint("cat1 is \(cat1), cat2 is \(cat2)")
        let cat1Predicate = NSPredicate(format: cat1.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat1,cat1,cat1,cat1)
        let cat2Predicate = NSPredicate(format: cat2.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat2,cat2,cat2,cat2)
        let searchPredicate = NSPredicate(format: filter.count > 0 ? "(name CONTAINS[c] %@) OR (metaKeywords CONTAINS[c] %@) ":"TRUEPREDICATE", filter.count > 0 ? filter:"*",filter.count > 0 ? filter:"*")
        
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [cat1Predicate, cat2Predicate,searchPredicate])
        request.predicate = andPredicate
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
        self._disableImageAnimation = disableImageAnimation
        self._bindingResultLimit = bindingResultLimit
        self._sidebar = sidebar
        self._isSearching = isSearching
        
        self.filter = filter
        self.resultLimit = resultLimit
        self.cat1 = cat1
        self.cat2 = cat2
        self.searchBarEmpty = filter.isEmpty
        self.width = width
        
    }
    
    var body: some View {
        return
//            List{
                ScrollView {
                VStack(alignment: .leading){
                    
                    KFImage(URL(string: "https://villa-banners-sg.s3-ap-southeast-1.amazonaws.com/Promotion/lamoon-1-free-1-900x350-eng.jpg")!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding(.leading, 40)
                    .padding(.trailing, 20)
                    .frame(width: self.width)
                    .animation(.easeInOut(duration: 1))

                    ForEach(productCores, id:\.self){ p in
                        ProductCoreTableCell(product: p,disableImageAnimation: self.$disableImageAnimation,sidebar: self.$sidebar, isSearching: self.$isSearching, width: self.width)
                    }
                }
                .frame(minWidth: 200, maxWidth: self.width)
                    //more button
                    
                    MoreButton(filter: self.filter, resultLimit: self.resultLimit, bindingResultLimit: self.$bindingResultLimit, cat1: self.cat1, cat2: self.cat2)
                                    
                }
//                .frame(minWidth: 300)
//                .frame(width: self.width)

    }
}






#if DEBUG
struct FormSectionProductTable_Previews: PreviewProvider {
    static var previews: some View {
        let context = SampleProductCore.context
        
        return Group{
            SearchViewProductTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(100), sidebar: .constant(false),cat1: "",cat2: "", isSearching: .constant(false), width: 400)
            .modifier(SubViewPreviewModifier(context: context))
            
            SearchViewProductTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(100), sidebar: .constant(true),cat1: "",cat2: "", isSearching: .constant(false), width: 300)
            .modifier(SubViewPreviewModifier(context: context))
            
            SearchViewProductTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(100), sidebar: .constant(false),cat1: "",cat2: "", isSearching: .constant(false), width: 500)
            .modifier(SubViewPreviewModifier(context: context))
                .previewDevice("IPhone 11 Pro Max")
        }
    }
}
#endif

