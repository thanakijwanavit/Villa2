
import SwiftUI
import CoreData




struct ProductCoreCollectionViewTable: View {
        @Binding var disableImageAnimation:Bool
        @Binding var bindingResultLimit:Int
        @Binding var sidebar:Bool
        var isSingleProduct:Bool
        var fetchRequest:FetchRequest<ProductCore>
        var productCores: FetchedResults<ProductCore>{
            fetchRequest.wrappedValue
        }
        //var for the more button
        @State var offsetVal:CGFloat = -100
    
        let filter:String
        let resultLimit:Int
        let cat1:String
        let cat2:String
//        let g:GeometryProxy
        let width:CGFloat
        var drag: some Gesture {
                DragGesture()
                    .onChanged { _ in self.offsetVal = 0}
            }
        
    init(filter: String, disableImageAnimation:Binding<Bool>, resultLimit: Int, bindingResultLimit: Binding<Int>, sidebar: Binding<Bool>, cat1:String, cat2:String, width:CGFloat, isSingleProduct:Bool){
            let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
            request.fetchLimit = resultLimit
//            debugPrint("cat1 is \(cat1), cat2 is \(cat2)")
            let cat1Predicate = NSPredicate(format: cat1.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat1,cat1,cat1,cat1)
            let cat2Predicate = NSPredicate(format: cat2.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat2,cat2,cat2,cat2)
            let searchPredicate = NSPredicate(format: filter.count > 0 ? "(name CONTAINS[c] %@) OR (metaKeywords CONTAINS[c] %@) ":"TRUEPREDICATE", filter.count > 0 ? filter:"*",filter.count > 0 ? filter:"*")
            
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [cat1Predicate, cat2Predicate,searchPredicate])
//            let sortDescriptor = NSSortDescriptor(key: "sku", ascending: true)
            
            request.predicate = andPredicate
            request.sortDescriptors = []
            self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
            self._disableImageAnimation = disableImageAnimation
            self._bindingResultLimit = bindingResultLimit
            self._sidebar = sidebar
            
            self.filter = filter
            self.resultLimit = resultLimit
            self.cat1 = cat1
            self.cat2 = cat2
            self.width = width
            self.isSingleProduct = isSingleProduct
        }
        
        var body: some View {
            return
                GeometryReader{ g in
                ScrollView(.horizontal,showsIndicators: false) {
                HStack(alignment: .center){
                    Spacer().frame(width: (self.width + 50) / 4, height: (self.width / 4) + 200)
                    ForEach(self.productCores, id:\.self){ p in
                        ProductCoreCollectionViewCell(product: p,disableImageAnimation: self.$disableImageAnimation,sidebar: self.$sidebar, imageWidth: self.width / 3, globalG: g, isSingleProduct: self.isSingleProduct)
                            .frame(width: (self.width + 50) / 4, height: (self.width / 4) + 250)
                            .offset(x: self.offsetVal, y: 0)
                    }
                }
                }
            }
                .frame( width: self.width, height: (self.width / 4) + 250)
//                .overlay(Rectangle().stroke(lineWidth: 1))
        }
}

struct ProductCoreCollectionViewTable_Previews: PreviewProvider {
    static var previews: some View {
        let context = SampleProductCore.context
        
        return GeometryReader { g in
            ProductCoreCollectionViewTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 5, bindingResultLimit: .constant(5), sidebar: .constant(false),cat1: "",cat2: "", width: 400, isSingleProduct: true)
            .modifier(SubViewPreviewModifier(context: context))
        }
    }
}
