import SwiftUI
import MapKit

struct CardView: View {
    var agency: Agence
    @State private var isDetailPresented = false

    var body: some View {
        VStack(alignment: .leading) {
            // Intégrer la carte dans la vue de la carte
            MapView(coordinate: CLLocationCoordinate2D(latitude: agency.latitude, longitude: agency.longitude))
                .frame(height: 170)
                .cornerRadius(-20)
                .padding(.top, -5)
                .onTapGesture {
                    openMaps()
                }
            HStack{
                VStack{
                    Text(agency.agenceName)
                        .font(.headline)
                    Text(agency.adresse)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.black)
                }
            
                Spacer()
                Spacer()
                Spacer()

            
                    Button(action: {
                        isDetailPresented.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                    }
                    .sheet(isPresented: $isDetailPresented) {
                        DetailView(agency: agency)
                    }

                    // Add a button with a phone icon
                   
                
            }
          
            
        }
        .padding()
        .background(
            Image("backround")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all))
        .cornerRadius(8)
        .padding(.vertical, 5)
    } 

    private func openMaps() {
        let coordinate = CLLocationCoordinate2D(latitude: agency.latitude, longitude: agency.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = agency.agenceName
        mapItem.openInMaps()
    }
}


struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        uiView.addAnnotation(annotation)

        // Régler la région de la carte pour afficher l'épingle
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        uiView.setRegion(region, animated: true)
    }
}
