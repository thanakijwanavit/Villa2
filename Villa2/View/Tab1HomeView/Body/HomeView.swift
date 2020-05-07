//
//  ProductsTable.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import CoreData

struct HomeView: View {
    
    var fetchRequest:FetchRequest<ProductCore>
    var productCores: FetchedResults<ProductCore>{
        fetchRequest.wrappedValue
    }
    @EnvironmentObject var catList:ProductCategoryList
    @Environment(\.managedObjectContext) var moc
    @State private var currentCatLabel:String = "Highlight"
    var mainCat:[ProductCategory] { get {self.catList.products.childrenData[0].childrenData}}
    
    var bannerList = ["villaBanner1","villaBanner2","villaBanner3","villaBanner4"]
    
    init(){
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        request.fetchLimit = 20
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
    }
    
    
    var body: some View {
        GeometryReader { g in
            
//            VStack{
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    
                    self.searchTab(g: g)
                    self.seperationLine(g: g)
                    self.fullSizeBanners(g: g)
//                    self.quarterSizeBanners()
//                    self.villaLogo(g: g)
                    self.searchIconsSection(g: g)
                    self.quarterSizeBanners()
                    self.recommendedProductChoices(g: g)
                    self.scrollingBanner(g:g)

                    self.recommendedProducts(g: g)
                }
                .frame(width: g.size.width)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    }
//            }
        }
    }
    // MARK:- UI items
    func fullSizeBanners(g:GeometryProxy) -> some View {
        KFImage(URL(string: "https://villa-banners-sg.s3-ap-southeast-1.amazonaws.com/Promotion/900x350_Pr_Eng_OUTLINED+(1).jpg")!)
        .resizable()
        .scaledToFit()
    }
    
    func quarterSizeBanners()-> some View {
        HStack{
            KFImage(URL(string: "https://villa-banners-sg.s3-ap-southeast-1.amazonaws.com/verticalBanners/305x397-Coolhaus.jpg")!)
            .resizable()
            .scaledToFit()
            KFImage(URL(string: "https://villa-banners-sg.s3-ap-southeast-1.amazonaws.com/verticalBanners/305x397-Coolhaus.jpg")!)
            .resizable()
            .scaledToFit()
            KFImage(URL(string: "https://villa-banners-sg.s3-ap-southeast-1.amazonaws.com/verticalBanners/305x397-Coolhaus.jpg")!)
            .resizable()
            .scaledToFit()
            KFImage(URL(string: "https://villa-banners-sg.s3-ap-southeast-1.amazonaws.com/verticalBanners/305x397-Coolhaus.jpg")!)
            .resizable()
            .scaledToFit()
        }
    }
    func searchIconsSection(g:GeometryProxy)-> some View {
        VStack{
            Text("Filter by categories")
            .font(.title)
            
            FilterIconsNavigationLinkTable(isOdd: true)
            .environment(\.managedObjectContext, self.moc)
                
            FilterIconsNavigationLinkTable(isOdd: false)
            .environment(\.managedObjectContext, self.moc)
        }
    }
    
    func scrollingBanner(g:GeometryProxy)-> some View {
        ScrollView(.horizontal){
           HStack(spacing: 10) {
            ForEach(self.bannerList, id: \.self){ imName in
                Image(uiImage: UIImage(named: imName)!.resizedImage(targetSize: CGSize(width: 400, height: 400)))
            }

           }
           .padding(.leading, 10)
        }.frame(height: 190)
    }
    func villaLogo(g: GeometryProxy)-> some View {
        KFImage(URL(string: "https://villa-images-sg.s3-ap-southeast-1.amazonaws.com/villaHeader.png")!)
        .resizable()
        .scaledToFit()
        .background(Color.white)
    }
    
    
    func icons(label:String, image:UIImage, activated:Bool)-> some View {
        ZStack(alignment: .bottom){
            
            Rectangle()
            .foregroundColor(.blue)
            .cornerRadius(10)
            .frame(width: 60, height: 30)
            .opacity(activated ? 0.8:0.2)
            
            VStack{
                Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 40)
            
                Text(label)
                .font(.system(size: 10))
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .frame(width: 60, height: 30)
                
            }
        }
    }
    
    func recommendedProductChoices(g: GeometryProxy)-> some View{
//        let activated:Bool = false
        let catLabels = ["Highlight","Bestsellers","Promotions","Seasonal"]
        let catImages = [#imageLiteral(resourceName: "bestSeller-1"),#imageLiteral(resourceName: "bestseller"),#imageLiteral(resourceName: "promotion"),#imageLiteral(resourceName: "seasonal")]
//        var currentCat = "Highlight"
        return VStack{
            HStack{
                ForEach(0..<catLabels.count, id: \.self){ id in
                    Button(action: {
                        self.currentCatLabel = catLabels[id]
                    }, label: {
                        self.icons(label: catLabels[id], image: catImages[id], activated: self.currentCatLabel == catLabels[id])
                    })
                    .padding()
                }
            }
            .buttonStyle(PlainButtonStyle())

            ProductCoreCollectionViewTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(10), sidebar: .constant(false),cat1: self.currentCatLabel == "Highlight" ? "147694":"" ,cat2: "", width: g.size.width, isSingleProduct: false)
        }
        
    }
    
    
    
    func recommendedProducts(g: GeometryProxy)-> some View {
        VStack{
            Text("Highlight")
                .font(.title)
            
            
            ProductCoreCollectionViewTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(10), sidebar: .constant(false),cat1: "147694",cat2: "", width: g.size.width, isSingleProduct: false)
                .padding(.vertical, 20)
            
            Text("Bestsellers")
                .font(.title)
            
            ProductCoreCollectionViewTable(filter: "", disableImageAnimation: .constant(false), resultLimit: 10, bindingResultLimit: .constant(10), sidebar: .constant(false),cat1: "",cat2: "", width: g.size.width, isSingleProduct: false)
            
            Text("Promotions")
                .font(.title)

            ProductCoreCollectionViewTable(filter: "", disableImageAnimation: .constant(false), resultLimit: 10, bindingResultLimit: .constant(10), sidebar: .constant(false) ,cat1: "38153",cat2: "", width: g.size.width, isSingleProduct: false)
        }
    }
    func searchTab(g: GeometryProxy)-> some View{
        NavigationLink(destination: SearchViewController(mainCatID: -1).environment(\.managedObjectContext, self.moc)) {
                            HStack {
                                Image("searchIcon")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                Text("All Products")
                                .font(.headline)
                                .padding(.horizontal)

                                Spacer()
                                
                            }
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: g.size.width , height: 40, alignment: .leading)
    }
    
    func seperationLine(g:GeometryProxy)-> some View {
        Rectangle()
        .frame(width: g.size.width, height: 2, alignment: .center)
            .foregroundColor(Color(.systemGray6))
    }
    
}

#if DEBUG
struct ProductsTable_Previews: PreviewProvider {
    static var previews: some View {
        
        return Group {
            HomeView()
            
            
            .environment(\.colorScheme, .dark)
        }
        .environment(\.managedObjectContext, SampleProductCore.context)
        .environmentObject(ProductCategoryList(productCategory: SampleCategory.category))

    }
}
#endif
