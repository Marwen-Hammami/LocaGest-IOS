import SwiftUI

struct SideBar: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var router: Router
    var body: some View {
        VStack{
            userAndDB()
                .padding()
            TabItemAndAnimation()
            Spacer()
            DarkToggle(vm: _vm)
        }
        .frame(maxWidth: 288, maxHeight: .infinity)
        .background(Color(.black))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous ))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    @ViewBuilder
    func userAndDB() -> some View{
        HStack{
            Image("person")
                .resizable()
                .scaledToFill()
                .mask(Circle())
                .frame(width: 60, height: 60)
            VStack{
                Text("name")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
                Text("@name")
                    .bold()
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                withAnimation(.easeIn){
                    vm.isopen.toggle()
                    vm.sideButton.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.white)
            })
        }
    }
    @ViewBuilder
    func TabItemAndAnimation()-> some View{
        VStack(spacing: 0, content: {
            Rectangle()
                .frame(height: 1)
                .opacity(0.2)
                .foregroundColor(.white)
                .padding(.horizontal)
            ForEach(sidebar){ item in
                Button(action: {
                    withAnimation{
                        vm.selecteditem = item.tab
                    }
                    switch item.tab{
                    case .user:
                        router.navigate(to: .user)
                    case .agence:
                        router.navigate(to: .agence)
                    case .chat:
                        router.navigate(to: .chat)
                    case .flotte:
                        router.navigate(to: .flotte)
                    case .garage:
                        router.navigate(to: .garage)
                    case .reservation:
                        router.navigate(to: .reservation)
                    }
                    vm.isopen.toggle()
                    vm.sideButton.toggle()
                }, label: {
                    HStack(spacing: 14){
                        Image(systemName: item.icon)
                            .font(.headline)
                        Text(item.titel)
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                })
                .foregroundStyle(vm.selecteditem == item.tab ? .white : .gray)
            }
        })
        .frame(width: 300, height: 340)
        .overlay(content: {
            VStack{
                switch vm.selecteditem {
                case .chat:
                    Spacer()
                case .agence:
                    Spacer()
                case .garage:
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                case .flotte:
                    Spacer()
                    Spacer()
                case .reservation:
                    Spacer()
                    Spacer()
                    Spacer()
                case .user:
                    EmptyView()
                }
                Rectangle()
                    .frame(width: 3, height: 25)
                    .foregroundStyle(Color("Accent"))
                    .cornerRadius(2)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
                switch vm.selecteditem {
                case .chat:
                    EmptyView()
                case .agence:
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                case .garage:
                    Spacer()
                case .flotte:
                    Spacer()
                    Spacer()
                    Spacer()
                case .reservation:
                    Spacer()
                    Spacer()
                case .user:
                    Spacer()
                }
                
            }
            .frame(height: 320)
            .frame(maxWidth: .infinity, alignment: .leading)
        })
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
            .environmentObject(ViewModel())
    }
}

struct DarkToggle: View{
    @EnvironmentObject var vm: ViewModel
    var body: some View{
        HStack{
            Image(systemName: "gearshape")
                .onTapGesture {
                    //Open settigs
                }
            Text("Dark Mode")
            Spacer()
            Toggle(isOn: $vm.toggleAction, label: {
                
            })
            .frame(width: 50, height: 50)
        }
        .padding()
        .foregroundColor(.white)
    }
}

/*
 import SwiftUI

 struct SideBar: View {
     @EnvironmentObject var vm: ViewModel
     @EnvironmentObject var router: Router
     var body: some View {
         VStack{
             userAndDB()
                 .padding()
             TabItemAndAnimation()
             Spacer()
             DarkToggle(vm: _vm)
         }
         .frame(maxWidth: 288, maxHeight: .infinity)
         .background(Color(.black))
         .mask(RoundedRectangle(cornerRadius: 30, style: .continuous ))
         .frame(maxWidth: .infinity, alignment: .leading)
     }
     @ViewBuilder
     func userAndDB() -> some View{
         HStack{
             Image("person")
                 .resizable()
                 .scaledToFill()
                 .mask(Circle())
                 .frame(width: 60, height: 60)
             VStack{
                 Text("name")
                     .bold()
                     .font(.title2)
                     .foregroundColor(.white)
                 Text("@name")
                     .bold()
                     .font(.callout)
                     .foregroundColor(.gray)
             }
             Spacer()
             Button(action: {
                 withAnimation(.easeIn){
                     vm.isopen.toggle()
                     vm.sideButton.toggle()
                 }
             }, label: {
                 Image(systemName: "xmark")
                     .font(.title2)
                     .foregroundColor(.white)
             })
         }
     }
     @ViewBuilder
     func TabItemAndAnimation()-> some View{
         NavigationView{
         VStack(spacing: 0, content: {
             Rectangle()
                 .frame(height: 1)
                 .opacity(0.2)
                 .foregroundColor(.white)
                 .padding(.horizontal)
             ForEach(sidebar){ item in
                 Button(action: {
                     withAnimation{
                         vm.selecteditem = item.tab
                     }
                     switch item.tab{
                     case .user:
                         router.navigate(to: .user)
                     case .agence:
                         router.navigate(to: .agence)
                     case .chat:
                         router.navigate(to: .chat)
                     case .flotte:
                         router.navigate(to: .flotte)
                     case .garage:
                         router.navigate(to: .garage)
                     case .reservation:
                         router.navigate(to: .reservation)
                     }
                     vm.isopen.toggle()
                     vm.sideButton.toggle()
                 }, label: {
                     HStack(spacing: 14){
                         Image(systemName: item.icon)
                             .font(.headline)
                         Text(item.titel)
                             .font(.title3)
                     }
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .padding()
                 })
                 .foregroundStyle(vm.selecteditem == item.tab ? .white : .gray)
             }
         })
         .frame(width: 300, height: 740)
         .overlay(content: {
             VStack{
                 switch vm.selecteditem {
                 case .chat:
                     Spacer()
                 case .agence:
                     Spacer()
                 case .garage:
                     Spacer()
                     Spacer()
                     Spacer()
                     Spacer()
                 case .flotte:
                     Spacer()
                     Spacer()
                 case .reservation:
                     Spacer()
                     Spacer()
                     Spacer()
                 case .user:
                     EmptyView()
                 }
                 Rectangle()
                     .frame(width: 3, height: 25)
                     .foregroundStyle(Color("Accent"))
                     .cornerRadius(2)
                     .padding(.vertical, 8)
                     .padding(.horizontal, 5)
                 switch vm.selecteditem {
                 case .chat:
                     EmptyView()
                 case .agence:
                     Spacer()
                     Spacer()
                     Spacer()
                     Spacer()
                 case .garage:
                     Spacer()
                 case .flotte:
                     Spacer()
                     Spacer()
                     Spacer()
                 case .reservation:
                     Spacer()
                     Spacer()
                 case .user:
                     Spacer()
                 }
                 
             }
             .frame(height: 320)
             .frame(maxWidth: .infinity, alignment: .leading)
         })
         .background(.black)
     }
     }
 }

 struct SideBar_Previews: PreviewProvider {
     static var previews: some View {
         SideBar()
             .environmentObject(ViewModel())
     }
 }

 struct DarkToggle: View{
     @EnvironmentObject var vm: ViewModel
     var body: some View{
         HStack{
             Image(systemName: "gearshape")
                 .onTapGesture {
                     //Open settigs
                 }
             Text("Dark Mode")
             Spacer()
             Toggle(isOn: $vm.toggleAction, label: {
                 
             })
             .frame(width: 50, height: 50)
         }
         .padding()
         .foregroundColor(.white)
     }
 }


*/
