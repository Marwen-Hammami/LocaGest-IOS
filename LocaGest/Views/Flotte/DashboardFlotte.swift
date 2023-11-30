//
//  DashboardFlotte.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 27/11/2023.
//

import SwiftUI

struct DashboardFlotte: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("Main"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()

                    CardView1()
                        .padding()

                    Spacer()

                    CardView2()
                        .padding()

                    Spacer()

                    CardView3()
                        .padding()

                    Spacer()
                }
                .navigationBarTitle("LocaGest")
                .toolbar {
                    // ... (votre barre de navigation)
                }
                .accentColor(.green)
            }
        }
    }
}

struct CardView1: View {
    var body: some View {
        NavigationLink(destination: DetailFlotte(cars: [])) {
            VStack {
                Image("car_7828724")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()

                Text("Voir la flotte")
                    .font(.headline)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}
struct CardView2: View {
    var body: some View {
        NavigationLink(destination: Page_Entretiens(entretiens: [])) {
            VStack {
                Image("wrench_7185363")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()

                Text("Historique des Entretiens")
                    .font(.headline)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

struct CardView3: View {
    var body: some View {
        VStack {
            Image("pin_10262932")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()

            Text("Géolocalisation")
                .font(.headline)
                .padding()

            
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct DashboardFlotte_Previews: PreviewProvider {
    static var previews: some View {
        DashboardFlotte()
    }
}
