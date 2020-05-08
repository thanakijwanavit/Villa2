//
//  WalletMainView.swift
//  Villa2
//
//  Created by nic Wanavit on 5/7/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct WalletMainView: View {
    var body: some View {
        NavigationView{
            GeometryReader{ g in
                VStack(alignment: .center){
                    
                    VStack(alignment: .center){
                        HStack{
                            Text("Name")
                            Text("Surname")
                        }
                        
                        HStack{
                            Text("VPlus No.")
                            Text("VXIX2048")
                        }
                    }
                    
                    // Balance and points
                    HStack{
                        HStack{
                            Image(uiImage: UIImage(named: "money")!.imageWithColor(tintColor: .gray))
                            .modifier(IconsModifier())
                            .padding()
                            VStack{
                                Text("123")
                                Text("Balance")
                            }
                        }
                        .frame(width: g.size.width/2)
                        HStack{
                            Image(uiImage: UIImage(named: "point")!.imageWithColor(tintColor: .gray))
                            .modifier(IconsModifier())
                            .colorMultiply(.white)
                            .padding()
                            VStack{
                                Text("1284")
                                Text("Points")
                            }
                        }
                        .frame(width: g.size.width/2)
                    }
                    .frame(width: g.size.width)
                    .padding(.vertical)
                    // scan and topup
                    HStack{
                        Button(action: {
//
                        }, label: {
                            HStack{
                                Image("scan")
//                                .renderingMode(.original)
                                .modifier(IconsModifier())
                                
                                Text("Scan")
                            }
                        })
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: g.size.width/2)
                        
                        Button(action: {
                        //
                        }, label: {
                            HStack{
                                Image("topup")
//                                .renderingMode(.original)
                                .modifier(IconsModifier())
                                
                                Text("Top Up")
                            }
                        })
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: g.size.width/2)
                    }
                    .padding(.vertical)
                    

                    VStack{
                        
                        Image("villaCard")
                        .resizable()
                        .scaledToFit()
                        .frame(width: g.size.width)
                        
                        ZStack{
//                            Color.white
                            Image(uiImage: UIImage(named: "barcode")!.withBackground(color: .white))
//                            Image("barcode")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(5)
                        }
                            Text("IX0392")
                        .frame(width: g.size.width/2 )
                    }
                    
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Villa Wallet")
        }
    }
}

struct WalletMainView_Previews: PreviewProvider {
    static var previews: some View {
        WalletMainView()
    }
}
