//
//  StoreSelector.swift
//  Villa2
//
//  Created by nic Wanavit on 5/6/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import MapKit

struct StoreSelectorMap: UIViewRepresentable {
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: StoreSelectorMap
        
        init(_ parent: StoreSelectorMap){
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            debugPrint(mapView.centerCoordinate)
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<StoreSelectorMap>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        for annotation in VillaLocations.annotations{
            mapView.addAnnotation(annotation.annotation)
        }
        
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<StoreSelectorMap>) {
        
    }
}

struct StoreFinder: View {
    var body: some View{
        ZStack{
            StoreSelectorMap()
            .edgesIgnoringSafeArea(.all)
            
        }
        .navigationBarTitle("Store Selector")
    }
}

struct StoreFinder_Previews: PreviewProvider {
    static var previews: some View {
        StoreFinder()
    }
}
