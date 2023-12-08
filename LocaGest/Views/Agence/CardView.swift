import SwiftUI
import MapKit

struct CardView: View {
    var agency: Agence
    @State private var isDetailPresented = false
    let phoneNumber = "29555555" // Replace with the actual phone number

    var body: some View {
        VStack(alignment: .leading) {
            // Intégrer la carte dans la vue de la carte
            MapView(coordinate: CLLocationCoordinate2D(latitude: agency.latitude, longitude: agency.longitude))
                .frame(height: 150)
                .cornerRadius(8)
                .padding(.top, 5)
                .onTapGesture {
                    openMaps()
                }

            Text(agency.agenceName)
                .font(.headline)
            Text(agency.adresse)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Button(action: {
                    isDetailPresented.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $isDetailPresented) {
                    DetailView(agency: agency)
                }

                // Add a button with a phone icon
                Button(action: {
                    if let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
                        UIApplication.shared.open(phoneURL)
                    }
                }) {
                    Image(systemName: "phone.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.green)
                }
            }
            
        }
        .padding()
        .background(Color(.systemGray6))
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
