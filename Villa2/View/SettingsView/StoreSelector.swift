//
//  StoreSelector.swift
//  Villa2
//
//  Created by nic Wanavit on 5/8/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI




struct StoreSelector: View {
    let storeList:[DefaultStore.storeLocation] = [.bangkok, .huahin, .phuket, .others]
    let storeDescriptionList:[String] = ["Bangkok", "HuaHin", "Phuket", "Others"]
    @Binding var isDisplayed:Bool
    
    init(isDisplayed:Binding<Bool>){
        self._isDisplayed = isDisplayed
        
    }
    
    var body: some View {
        VStack{
            Text("Which store would you like to shop in?")
            .font(.headline)
            .bold()
            .padding()
            
            ForEach(0..<storeList.count){ i in
                Button(action: {
                    DefaultStore.currentStore = self.storeList[i]
                    self.dismissDisplay()
                    }) {
                        Text(self.storeDescriptionList[i])
                        .font(.callout)
                }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(.gray)
                .frame(width: 100, height: 50, alignment: .center)
                .overlay(Capsule().stroke(lineWidth: 5).foregroundColor(.blue).opacity(0.5))
                .padding()
            }
        }
        .onAppear{
            self.dismissDisplay()
        }
    }
    func dismissDisplay (){
        if let currentStore = DefaultStore.currentStore{
            debugPrint(currentStore)
            self.isDisplayed = false
        }
    }
}

struct StoreSelector_Previews: PreviewProvider {
    static var previews: some View {
        StoreSelector(isDisplayed: .constant(true))
    }
}
