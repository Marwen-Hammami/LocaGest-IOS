import SwiftUI
@main
struct LocaGestApp: App {
    @StateObject var viewModel: ViewModel = ViewModel()
    @ObservedObject var router = Router()
    @State private var showSplash = true // Added state variable for controlling splash screen visibility
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showSplash { // Show splash screen conditionally
                    SplashScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showSplash = false // Hide splash screen after 3 seconds
                                
                                

                            }
                        }
                    
                }
                            else {
                    NavigationStack(path: $router.navPath){
                        LoginView()
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
    }
}
