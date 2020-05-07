//
//  SearchViewSideBarSearchIcon.swift
//  Villa2
//
//  Created by nic Wanavit on 4/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI
struct SideBarSearchIcons: View{
    var mainCat:[ProductCategory]
    var currentCat: Int
    @Binding var currentSubCat: Int
    var sideBarWidth: CGFloat
    var subcat:[ProductCategory] {
        get {
            return self.currentCat == -1 ? self.mainCat[0].childrenData : self.mainCat[self.currentCat].childrenData
        }
    }
    var body: some View {
        HStack{
            ScrollView{
            VStack(spacing: 10){
                
                
                // all search icon
                Group {
                    Button(action: {
                        self.currentSubCat = -1
                    }){
                        Text("All Products")
                            .font(.system(size: 15))
                            .truncationMode(.tail)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.2)
                            .padding(.horizontal, 5)
                            .padding(.vertical)
                        .frame(width: self.sideBarWidth)
                    }
                    .buttonStyle(SideIconsButtonStyle(activated: -1 == self.currentSubCat,width: self.sideBarWidth))
                }
                
                //other search icons
                ForEach(0..<self.subcat.count, id: \.self){subCatId in
                    Group {
                        Button(action: {
                            self.currentSubCat = subCatId
                        }){
                            if self.subcat[subCatId].isActive{
                                Text(self.subcat[subCatId].name)
                                    .font(.system(size: 15))
                                    .truncationMode(.tail)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.2)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical)
                                .frame(width: self.sideBarWidth)
                            }
                        }
                        .buttonStyle(SideIconsButtonStyle(activated: subCatId == self.currentSubCat,width: self.sideBarWidth))
                    }
                }
            }
            }
            .frame(width: self.sideBarWidth, alignment: .leading)
            .transition(.move(edge: .leading))
            Spacer()
        }
    }
}
