
import SwiftUI
import MapKit





struct DeliveryLocationMap: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locationManager:CLLocationManager
    @Binding var centerToCurrentLocation:Bool
    var annotation: MKPointAnnotation?
//    var locationManager = CLLocationManager()
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate{
        var parent: DeliveryLocationMap
        
        init(_ parent: DeliveryLocationMap){
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
            let centerAnnotation = MKPointAnnotation()
            centerAnnotation.coordinate = mapView.centerCoordinate
            
            parent.annotation = centerAnnotation
        }
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    
    func makeUIView(context: UIViewRepresentableContext<DeliveryLocationMap>) -> MKMapView {
        
        let mapView = MKMapView()
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsBuildings = true

        var currentLocation = CLLocation(latitude: 13.7563, longitude: 100.5018)
        
        locationManager.delegate = context.coordinator
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 1000
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways)
        {
            currentLocation = locationManager.location ?? currentLocation
        }
        
        if CLLocationManager.headingAvailable()
        {
            locationManager.headingFilter = 5
            locationManager.startUpdatingHeading()
        }
        
        
        let region = MKCoordinateRegion( center: currentLocation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.delegate = context.coordinator
        
        
        
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<DeliveryLocationMap>) {
        if annotation?.coordinate.latitude != uiView.annotations.first?.coordinate.latitude {
            for oldAnnotation in uiView.annotations{
                uiView.removeAnnotation(oldAnnotation)
            }
            if let annotation = annotation{
                uiView.addAnnotation(annotation)
            }
        }
        if self.centerToCurrentLocation {
            debugPrint("UIMK try to set new center")
            uiView.setCenter(self.locationManager.location?.coordinate ?? uiView.centerCoordinate , animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.centerToCurrentLocation = false
            }
        }
    }
    
    
}

struct DeliveryLocation: View {
    @State private var centerCoordinate:CLLocationCoordinate2D
    @State private var location:MKPointAnnotation?
    @State private var locationManger:CLLocationManager
    @State var centerToCurrentLocation:Bool
    @Binding var isDisplayed:Bool
    
    init(isDisplayed: Binding<Bool>){
        self._centerCoordinate = State(initialValue: CLLocationCoordinate2D())
        self._location = State(initialValue: nil)
        self._locationManger = State(initialValue: CLLocationManager())
        self._centerToCurrentLocation = State(initialValue: false)
        self._isDisplayed = isDisplayed
    }
    
    var body: some View{
        ZStack{
            ZStack{
                DeliveryLocationMap(centerCoordinate: self.$centerCoordinate, locationManager: self.$locationManger, centerToCurrentLocation: self.$centerToCurrentLocation, annotation: self.location)
                                
                Image(uiImage: UIImage(systemName: "xmark",withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))!.withTintColor(.gray, renderingMode: .alwaysTemplate))
                .opacity(0.5)
                
            }
            .frame(alignment:.center)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.centerToCurrentLocation = true
                        debugPrint("set center to current location")
                    }) {
                        Image(systemName: "location")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                    
                    
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        self.location = newLocation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isDisplayed = false
                        }
                    }) {
                        Image(systemName: "checkmark")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .navigationBarTitle("Delivery Location")
    }
}

struct DeliveryLocation_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryLocation(isDisplayed: .constant(true))
    }
}
