import SwiftUI

struct FlotteMainView: View {
    @EnvironmentObject var vm: ViewModel
    @StateObject var carViewModel = CarViewModel()
    @StateObject var entretienViewModel = EntretienViewModel()
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            
            SideBar()
                .opacity(vm.isopen ? 1 : 0)
            ZStack{
                Color(.white)
                LinearGradient(
                    gradient: Gradient(colors: [Color("Main"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack{
                    HStack{
                        SideBarButton()
                        
                        Text("Accueil")
                            .font(.title)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    
                    HomeView()
                }
                .padding(.top, 50)
            }

            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(.degrees(30), axis: (x: 0, y: vm.isopen ? -1 : 0, z: 0))
            .offset(x: vm.isopen ? 250 : 0)
            .ignoresSafeArea()
        }
        .onAppear {
            vm.selecteditem = .flotte
        }
    }
    @ViewBuilder
    func SideBarButton()-> some View{
        if vm.sideButton{
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)){
                    vm.isopen.toggle()
                    vm.sideButton.toggle()
                }
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title)
                    .foregroundColor(.black)
            })
        }
    }
    
    @ViewBuilder
    func HomeView()-> some View{
        // Start - Here you can put your work ************************
        DashboardFlotte(carViewModel: carViewModel, entretienViewModel: entretienViewModel)
        
        
        // End   - Here you can put your work ************************
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//struct FlotteMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlotteMainView(carViewModel: carViewModel)
//            .environmentObject(ViewModel())
//    }
//}
