//
//  FilterIconsNavigationLinkTable.swift
//  Villa2
//
//  Created by nic Wanavit on 4/15/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct FilterIconsNavigationLinkTable: View {
    @EnvironmentObject var catList:ProductCategoryList
    @Environment(\.managedObjectContext) var moc

    var mainCat:[ProductCategory] { get {self.catList.products.childrenData[0].childrenData}}
    var isOdd:Bool
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 10) {
                ForEach(
                    self.mainCat.filter(
                        { (cat) -> Bool in
                    return cat.isActive
                    }
                    ).enumeratedArray()[..<10] , id:\.element){ id, cat in
                    Group {
                        if id % 2 == (self.isOdd ? 1:0) {
                            NavigationLink(destination:
                                SearchViewController(mainCatID: self.getCatId(cat: cat))
                                .environment(\.managedObjectContext, self.moc)
                                .environmentObject(self.catList)
                            ) {
                                
                                VStack{
                                    Image(uiImage: UIImage(named: cat.name) ?? UIImage(named: "Grocery")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 40)
                                
                                    Text(cat.name)
                                    .font(.system(size: 10))
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(2)
                                    .frame(width: 60, height: 30)
                                    
                                }
                                
                            }
                            .frame(width: 70, height: 70, alignment: .center)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
    }
    
    
    func getCatId(cat:ProductCategory)->Int{
        return self.mainCat.firstIndex(where: { (foundCat) -> Bool in
            return foundCat.name == cat.name
            }) ?? -1
    }
}

struct FilterIconsNavigationLinkTable_Previews: PreviewProvider {
    static var previews: some View {
        FilterIconsNavigationLinkTable(isOdd: true)
    }
}
