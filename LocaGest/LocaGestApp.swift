import SwiftUI

@main
struct LocaGestApp: App {
    @StateObject var viewModel: ViewModel = ViewModel()
    @ObservedObject var router = Router()
    @State private var showSplash = true
    @State private var showSignIn = false
    
    var body: some Scene {
        WindowGroup {
          
                      
                 
            Group {
                if showSplash {
                    SplashScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showSplash = false
                                showSignIn = true
                            }
                        }
                } else if showSignIn {
                    LoginView()
                        .environmentObject(viewModel)
                        .onAppear {
                            // Perform any necessary setup for the sign-in screen
                        }
                } else {
                    NavigationStack(path: $router.navPath){
                        FlotteMainView()
                            .environmentObject(viewModel)
                            .navigationBarBackButtonHidden(true)
                            .navigationDestination(for: Router.Destination.self) { destination in
                                switch destination {
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
