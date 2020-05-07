//
//  SearchTopFilterTableView.swift
//  Villa2
//
//  Created by nic Wanavit on 4/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData


struct MainCatSearchIcons: View{
    var mainCat:[ProductCategory]
    @Binding var currentCat: Int
    @Binding var currentSubCat: Int
    @Binding var sidebar:Bool
    @Binding var resultLimit:Int

    var body: some View {
        ScrollView([.horizontal], showsIndicators: false){
            HStack(spacing: 10) {
                
                // all wildcard
                Group {
                    Button(action :{
                        self.currentCat = -1
                        self.currentSubCat = -1
                        self.sidebar = false
                        self.incrementalIncreaseProducts()
                    }){
                        VStack{
                        Image("all")
                        .resizable()
                        .scaledToFit()
                        .frame(width:30,height:30)
                            
                        Text("All")
                        .font(.system(size: 10))
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .lineLimit(2)
                        .frame(width: 30, height: 10)
                            
                        }
//                        Text("All")
//                        .font(.headline)
//                        .frame(height: 30)
//                        .padding()
                        
                    }
                    .buttonStyle(TopIconsButtonStyle(activated: -1 == self.currentCat))
                    }
                
                ForEach(0..<self.mainCat.count, id: \.self){catId in
                    Group {
                        if self.mainCat[catId].isActive && self.mainCat[catId].name != "Gourmet" {
                            Button(action :{
                                self.currentCat = catId
                                self.currentSubCat = -1
                                self.sidebar = true
                                self.incrementalIncreaseProducts()
                            }){
                                VStack{
                                    Image(uiImage: UIImage(named: self.mainCat[catId].name) ?? UIImage(named: "Grocery")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                
                                    Text(self.mainCat[catId].name)
                                    .font(.system(size: 10))
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(2)
                                    .frame(width: 30, height: 10)
                                    
                                }
                                
                            }
                            .buttonStyle(TopIconsButtonStyle(activated: catId == self.currentCat))
                        }
                    }
                }
            }.frame(height: 50)
        }//.frame(width: 250)
    }
    private func incrementalIncreaseProducts(){
        self.resultLimit = 20
    }
}


