import SwiftUI

struct ReservationListView: View {
    @StateObject private var reservationModel = ReservationModel()
    @State private var isShowingAddPage = false
    @State private var showDeleteConfirmation = false
    @State private var selectedStatus: StatutRes? = nil
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(reservationModel.reservations.filter { reservation in
                        selectedStatus == nil || reservation.statut == selectedStatus
                    }) { reservation in
                        ReservationCardView(reservation: reservation)
                            .contextMenu {
                                Button(action: {
                                    if let index = reservationModel.reservations.firstIndex(where: { $0.id == reservation.id }) {
                                        reservationModel.deleteReservation(at: index)
                                    }
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .environmentObject(reservationModel)
                    }
                }
                /*.background(Image("back1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: screenWidth, height: screenWidth))*/
                Spacer()
                
                bottomNavigationBar()
            }
            .navigationBarTitle("Reservations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .sheet(isPresented: $isShowingAddPage) {
                AddReservation(reservationModel: reservationModel) { newReservation in
                    reservationModel.addReservation(newReservation)
                }
            }
        }
         //.background(Image("back1"))

    }
    
    func addButton() -> some View {
        Button(action: {
            isShowingAddPage = true
        }) {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.primary)
                .clipShape(Circle())
        }
    }
    
    func bottomNavigationBar() -> some View {
        HStack {
            Spacer()
            
            Button(action: {
                selectedStatus = nil // Afficher toutes les réservations
            }) {
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundColor(selectedStatus == nil ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
            
            Button(action: {
                selectedStatus = .achevee // Afficher les réservations achevées
            }) {
                Image(systemName: "checkmark.circle")
                    .font(.title2)
                    .foregroundColor(selectedStatus == .achevee ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
            
            Button(action: {
                selectedStatus = .payee // Afficher les réservations payées
            }) {
                Image(systemName: "dollarsign.circle")
                    .font(.title2)
                    .foregroundColor(selectedStatus == .payee ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
            
            Button(action: {
                selectedStatus = .annulee // Afficher les réservations annulées
            }) {
                Image(systemName: "xmark.circle")
                    .font(.title2)
                    .foregroundColor(selectedStatus == .annulee ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
        }
        
    }
}

struct ReservationListView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationListView()
    }
}
