//
//  SearchViewController+Extension.swift
//  Villa2
//
//  Created by nic Wanavit on 4/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI
import CoreData


extension SearchViewController{
    func sidebarWidth(g: GeometryProxy)->CGFloat{
        return g.size.width / 4
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
    func fetchApi(){
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.performBackgroundTask { (backgroundContext) in
            S3Api.getProductCores(context: backgroundContext)
            self.reloadUI()
        }
    }
    // updateui
    func reloadUI(){
        DispatchQueue.main.async {
            self.sidebar.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.sidebar.toggle()
            }
        }
        moc.refreshAllObjects()
    }
    
    
    func dragValue(translation:CGSize, sidebar:Binding<Bool>, showCat:Binding<Bool>){
        if translation.width < -50 {
            withAnimation {
                self.sidebar = false
                debugPrint("hiding sidebar")
            }
        } else if translation.width > 50{
            withAnimation{
                self.sidebar = true
            }
        }
        if translation.height > 100 {
            withAnimation{

                self.showCat = true
            }
        } else if translation.height < -100{
            withAnimation{
                debugPrint("hiding cat")
                self.showCat = false
            }
        }
    }
    
    func productTableWidth(g:GeometryProxy)->CGFloat{
        return self.sidebar ? g.size.width - self.sidebarWidth(g: g) : g.size.width
    }
    
}
