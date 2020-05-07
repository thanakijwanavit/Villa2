//
//  NavigationBarLeadingItems.swift
//  Villa2
//
//  Created by nic Wanavit on 4/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData
struct SearchViewNavigationBarLeadingItems: View {
//    @Binding var sidebar:Bool
    @Binding var currentCat: Int
    @Binding var currentSubCat: Int
    @Binding var sidebar:Bool
    @Binding var resultLimit:Int
    
    @EnvironmentObject var catList:ProductCategoryList
    var mainCat:[ProductCategory] { get {self.catList.products.childrenData[0].childrenData}}
    var body: some View {
        HStack{
            if self.currentCat != -2 {
                MainCatSearchIcons(mainCat: self.mainCat, currentCat: self.$currentCat, currentSubCat: self.$currentSubCat, sidebar: self.$sidebar, resultLimit: self.$resultLimit )
            .frame(width: 250)
            }
//            .gesture(drag)
            
//            Button(action: {self.sidebar.toggle()}){
//                Image(systemName: "line.horizontal.3")
//                .frame(width: 40, height: 40)
//            }
//            Button(action: {
//                self.deleteAllItems()
//            }){
//                Image(systemName: "trash")
//            }
//            .frame(width: 40, height: 40)
//
//            Button(action: {
//                self.fetchApi()
//            }){
//                Image(systemName: "gobackward")
//            }
//            .frame(width: 40, height: 40)
//            .buttonStyle(DefaultButtonStyle())
            
            
        }
//        .frame(height:200)
    }
}

extension SearchViewNavigationBarLeadingItems{
    func fetchApi(){
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.performBackgroundTask { (backgroundContext) in
            S3Api.getProductCores(context: backgroundContext)
            self.reloadUI()
        }
    }
    func reloadUI(){
        DispatchQueue.main.async {
            self.sidebar.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.sidebar.toggle()
            }
        }
    }
        
        
    func deleteAllItems(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCore")
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try moc.execute(batchDeleteRequest)
            try moc.save()
            moc.reset()
            self.reloadUI()
            debugPrint("all items deleted")
        } catch {
            // Error Handling
            debugPrint("error deleting and saving")
        }
    }
        
}


struct SearchViewNavigationBarLeadingItems_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewNavigationBarLeadingItems(currentCat: .constant(1), currentSubCat: .constant(1), sidebar: .constant(true), resultLimit: .constant(10))
    }
}
