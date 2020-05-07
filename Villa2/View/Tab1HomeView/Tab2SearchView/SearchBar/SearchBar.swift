 //
//  SearchBar.swift
//  Villa2
//
//  Created by nic Wanavit on 3/28/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text:String
    @Binding var showCat:Bool
    @Binding var sidebar:Bool
    @Binding var disableImageAnimation:Bool
    @Binding var resultLimit:Int
    @State var showMagnifying:Bool = true
    @Binding var isSearching:Bool

    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .opacity(self.showMagnifying ? 1:0)
                .frame(maxWidth: self.showMagnifying ? 40:1)
                .padding(.leading)
                .animation(.easeInOut)
                .onTapGesture {
                    self.showCat.toggle()
            }
            TextField("Search", text: $text,onEditingChanged: { editing in
                if editing {
                    self.showCat = true
                    self.sidebar = false
                    self.disableImageAnimation = true
                    self.showMagnifying = false
                    self.resultLimit = 20
                    self.isSearching = true
                    
                } else {
                    self.showMagnifying = true
                    self.resultLimit = 100
                    self.disableImageAnimation = true
                    self.isSearching = false
                }
            }, onCommit: {
                self.showCat = true
//                self.sidebar = true
                self.disableImageAnimation = false
            })
                .modifier(ClearButton(text: self.$text))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal)
                .padding(.vertical, 3.0)
                .overlay(Capsule().stroke(Color.blue.opacity(0.5), lineWidth: 5))
    //            .frame( height: 30, alignment: .center)
    //            .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(Color.blue.opacity(0.2),lineWidth: 5))
    //            .background(Color.gray)
                .padding(.trailing)
        }.padding(.top)
    }
}

 struct ClearButton: ViewModifier
 {
     @Binding var text: String

     public func body(content: Content) -> some View
     {
         HStack()
         {
            content
            
            if !text.isEmpty
            {
                 Button(action:
                 {
                     self.text = ""
                 })
                 {
                     Image(systemName: "delete.left")
                         .foregroundColor(Color(UIColor.opaqueSeparator))
                 }
//                    .disabled(false)
//                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.trailing, 8)
                }
         }
     }
 }
 
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("hello"),showCat: .constant(true), sidebar: .constant(true),disableImageAnimation: .constant(false), resultLimit: .constant(20), isSearching: .constant(false))
    }
}
