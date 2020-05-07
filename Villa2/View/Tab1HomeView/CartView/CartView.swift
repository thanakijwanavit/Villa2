//
//  CartView.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData

struct CartView: View {
    
//    @EnvironmentObject var productList:ProductList
//    @EnvironmentObject var rootGeometry:RootGeometry
//    @EnvironmentObject var user:CurrentUser
    @State var payment = false
    var fetchRequest: FetchRequest<ProductCore>
    var productCores: FetchedResults<ProductCore>{
        self.fetchRequest.wrappedValue
    }
    @State var address:String = "some address"
    
    init(){
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        request.fetchLimit = 100
        let predicate = NSPredicate(format: "isInCart == TRUE")
        request.predicate = predicate
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
    }
    var body: some View {
            VStack{
                ZStack{
                    Color(UIColor.systemBackground)
                    CartProductTable( productCores: self.productCores)
                }
                HStack{
                    Text("your address is : ")
                    TextField("address", text: self.$address)
                    .lineLimit(3)
                }
            }.navigationBarTitle(
            Text("Checkout")
            , displayMode: .large)
            .navigationBarItems(leading: Text("edit"), trailing: Button(action: {self.payment.toggle()}){Text("pay")})
            .sheet(isPresented: $payment){
                PaymentView()
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}


struct PaymentView: View {
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                Form {
                    Section(header: Text("Credit Card").font(.title)) {
                        VStack(alignment: .center){
                            Image("visaLogo")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: self.idealWidth(geometry: geometry) , height: self.idealWidth(geometry: geometry)/2.8)
                                .cornerRadius(self.idealWidth(geometry: geometry)/20)
                                .padding()
                        }
                    }
                    .frame(width: self.idealWidth(geometry: geometry),alignment: Alignment.center)
                    
                    Section(header: Text("Villa Wallet").font(.title)) {
                        VStack(alignment: .center){
                            Image("villaLogo")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: self.idealWidth(geometry: geometry) , height: self.idealWidth(geometry: geometry)/2.8)
                                .cornerRadius(self.idealWidth(geometry: geometry)/20)
                                .padding()
                        }
                        
                    }
                    .frame(width: self.idealWidth(geometry: geometry),alignment: Alignment.center)
                }
                .navigationBarTitle("Payment", displayMode: .large)
            }
        }
    }
    func idealWidth(geometry:GeometryProxy)-> CGFloat{
        return CGFloat(geometry.size.width - 30)
    }
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CartView()
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewLayout(.device)
            
            CartView()
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
            .previewLayout(.device)
            
            
            PaymentView()
            
            
            PaymentView()
                .environment(\.colorScheme, .dark)
        }
        .environment(\.managedObjectContext, SampleProductCore.context)
        .environmentObject(SampleCurrentUser.user)

    }
}
