//
//  updateDist.swift
//  LocaGest
//
//  Created by Mac Mini 2 on 30/11/2023.
//

import SwiftUI

struct updateDist: View {
    
    
    @State private var typeR: String = ""
    @State private var pieces: [String] = ["Cardon" , "Chaine" , "Disque" ]
    @State private var cars: [String] = ["Golf", "Peugeot206+"]
    @State private var technicien: [String] = ["ayoub hamoudi " , "chokri ben jalloul "]
    @State private var description: String = ""
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var statusCar: String = ""
    @State private var selectedTypeRIndex = 0
    @State private var selectedStatusIndex = 0
    @State private var selectedCarsIndex = 0
    @State private var selectedTechIndex = 0
    @State private var selectedPieceIndex = 0
    
    
    let validStatusValues = ["In Progress", "Delivered"]
    let validTypeRValues = ["Maintenance", "Repair", "Car Wash"]
    
    @State private var isScrolling = false
    
    
    
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Text("modify Distribution")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 0)
                
                
                
                
                
                VStack {
                    
                    VStack (alignment: .leading, spacing: 0){
                        
                        VStack {Text("Type of Repair")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            Picker("Type of Repair", selection: $selectedTypeRIndex) {
                                ForEach(0..<validTypeRValues.count) { index in
                                    Text(validTypeRValues[index])
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            
                            
                            
                            
                            
                            VStack {Text("statusCar")
                                    .font(.headline)
                                
                                    .padding(.bottom, 4)
                                
                                Picker("statusCar", selection: $selectedStatusIndex) {
                                    ForEach(0..<validStatusValues.count) { index in
                                        Text(validStatusValues[index])
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                                
                                VStack {Text("Voiture")
                                        .font(.headline)
                                    
                                        .padding(.bottom, 4)
                                    
                                    Picker("Voiture", selection: $selectedCarsIndex) {
                                        ForEach(0..<cars.count) { index in
                                            Text(cars[index])
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    VStack {Text("Technicien")
                                            .font(.headline)
                                        
                                            .padding(.bottom, 4)
                                        
                                        Picker("Technicien", selection: $selectedTechIndex) {
                                            ForEach(0..<technicien.count) { index in
                                                Text(technicien[index])
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.horizontal)
                                        VStack {Text("Pieces ")
                                                .font(.headline)
                                            
                                                .padding(.bottom, 4)
                                            
                                            Picker("Pieces", selection: $selectedPieceIndex) {
                                                ForEach(0..<pieces.count) { index in
                                                    Text(pieces[index])
                                                }
                                            }
                                            .pickerStyle(MenuPickerStyle())
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding(.horizontal)
                                            
                                            
                                        }
                                        VStack{
                                            Text("description")
                                                .font(.headline)
                                                .padding(.bottom, 4)
                                            TextField("description", text: $description)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    
                                    Button(action: {
                                        
                                    }) {
                                        HStack {
                                            Text("Modify Distribution")
                                                .fontWeight(.medium)
                                                .padding(.leading, 9)
                                                .padding(.vertical, 6)
                                                .foregroundColor(Color.white)
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.leading)
                                                .background(RoundedRectangle(cornerRadius: 4)
                                                    .fill(Color.green))
                                                .padding(.horizontal, 28)
                                        }
                                    }
                                    .background(RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.green))
                                    .padding(.horizontal, 28)
                                    
                                }
                                .padding(.horizontal, 16)
                                .animation(.easeInOut)
                                .onAppear {
                                    isScrolling = false
                                }
                                .onDisappear {
                                    isScrolling = true
                                }
                            }
                        }
                    }
                    
                    
                    
                    
                }
                
            }
            
        }}}


struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        updateDist()
    }
}
