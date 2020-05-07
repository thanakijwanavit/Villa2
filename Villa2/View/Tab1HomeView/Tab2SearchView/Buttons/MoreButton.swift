//
//  MoreButton.swift
//  Villa2
//
//  Created by nic Wanavit on 4/3/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData
struct MoreButton: View {
    var fetchRequest:FetchRequest<ProductCore>
    var productCores: FetchedResults<ProductCore>{
        fetchRequest.wrappedValue
    }
    var resultLimit:Int
    @Binding var bindingResultLimit:Int
    
    init(filter: String, resultLimit: Int, bindingResultLimit: Binding<Int>,  cat1:String, cat2:String){
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        //request for 1 more than the limit
        request.fetchLimit = resultLimit + 1
//        debugPrint("cat1 is \(cat1), cat2 is \(cat2)")
        let cat1Predicate = NSPredicate(format: cat1.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat1,cat1,cat1,cat1)
        let cat2Predicate = NSPredicate(format: cat2.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat2,cat2,cat2,cat2)
        let searchPredicate = NSPredicate(format: filter.count > 0 ? "(name CONTAINS[c] %@) OR (metaKeywords CONTAINS[c] %@) ":"TRUEPREDICATE", filter.count > 0 ? filter:"*",filter.count > 0 ? filter:"*")
        
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [cat1Predicate, cat2Predicate,searchPredicate])
        request.predicate = andPredicate
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
        self.resultLimit = resultLimit
        //attach binding
        self._bindingResultLimit = bindingResultLimit
    }
    
    var body: some View {
        Button(action: {
            self.bindingResultLimit += 40
        }){
            Text("more")
        }
        .disabled(productCores.count > resultLimit ? false:true)
        .padding(.bottom,100)

    }
}

//struct MoreButton_Previews: PreviewProvider {
//    static var previews: some View {
//        MoreButton()
//    }
//}
