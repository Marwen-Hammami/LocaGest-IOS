import SwiftUI

@main
struct LocaGestApp: App {
    @StateObject var viewModel: ViewModel = ViewModel()
    @StateObject private var reservationModel = ReservationModel()
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath){
                FlotteMainView()
                    .environmentObject(viewModel)
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(for: Router.Destination.self){
                        destination in
                        switch destination{
                        case .user:
                            UserMainView()
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden(true)
                        case .agence:
                            AgenceMainView()
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden(true)
                        case .flotte:
                            FlotteMainView()
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden(true)
                        case .reservation:
                            ReservationMainView()
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden(true)
                                .environmentObject(reservationModel)
                        case .garage:
                            GarageMainView()
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden(true)
                        case .chat:
                            ChatMainView()
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
