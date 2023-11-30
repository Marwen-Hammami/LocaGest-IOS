import SwiftUI

struct AgenceView: View {
    @State private var showForm = false
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(agencies) { agency in
                        NavigationLink(destination: DetailView(agency: agency)) {
                            VStack(alignment: .leading) {
                                Text(agency.agenceName)
                                Text(agency.adresse)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }

                Button(action: { self.showForm.toggle() }) {
                    Text("Ajouter une agence")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $showForm) {
                FormView()
            }
            .navigationBarTitle("Mes Agences", displayMode: .inline)
        }
    }
}

struct DetailView: View {
    let agency: Agence
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert : Bool = false

    var body: some View {
            VStack(alignment: .center) {
                
                Image(systemName: "building.2.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color("Main"))
                Text(agency.agenceName)
                    .font(.largeTitle)
                    .bold()
                    .padding()

                VStack(alignment : .leading){
                HStack {
                    Text("Address:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(agency.adresse)
                        .font(.body)
                }
                .padding()

                HStack {
                    Text("Head ID:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(agency.idHead)
                        .font(.body)
                }
                .padding()

                HStack {
                    Text("Longitude:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("\(agency.longitude)")
                        .font(.body)
                }
                .padding()

                HStack {
                    Text("Latitude:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("\(agency.latitude)")
                        .font(.body)
                }
                .padding()
            }
                HStack{
                    Spacer()
                    NavigationLink(destination: FormUpdateView(agency: agency)) {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                    }
   

                
                    Spacer()
                    Button(action: {
                    // Add your button action here
                        showAlert = true
                    }) {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Êtes-vous sûres?"),message: Text("Êtes vous sûres de vouloir supprimer l'agence \(agency.agenceName) "),
                              primaryButton: .destructive(Text("Supprimer")){
                            dismiss()
                        },
                              secondaryButton: .cancel() )
                    }
                Spacer()
                        
                }
            }
        .navigationBarTitle(agency.agenceName, displayMode: .inline)
    }
}

struct FormUpdateView: View {
    let agency: Agence
    
    @State private var showAlertUpdate : Bool = false
    
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var address = ""
    @State private var assigneeID = ""
    @State private var latitude = ""
    @State private var longitude = ""

    let assignees = ["Mohammed", "Khaled", "Samir"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Nom de l'agence")
                    TextField("Nom de l'agence", text: $name)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    Text("Adresse de l'agence")
                    TextField("Adresse de l'agence", text: $address)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Section {
                    Picker(selection: $assigneeID, label: Text("Chef d'agence")) {
                        ForEach(0..<assignees.count) { index in
                            Text(self.assignees[index]).tag(index)
                        }
                    }
                }

                Section {
                    Text("Latitude")
                    TextField("Latitude", text: $latitude)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    Text("Longitude")
                    TextField("Longitude", text: $longitude)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)

                }


            }
            .navigationBarTitle("Modifir une agence", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // Action for Cancel button
                dismiss()
                self.name = ""
                self.address = ""
                self.assigneeID = ""
                self.latitude = ""
                self.longitude = ""
            }) {
                Text("Annuler")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.red)
            })
            .navigationBarItems(trailing: Button(action: {
                // Action for Cancel button
                showAlertUpdate = true
                
            }) {
                Text("Modifier")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.blue)
            })
            .alert(isPresented: $showAlertUpdate){
                Alert(title: Text("Êtes-vous sûres?"),message: Text("Êtes vous sûres de vouloir modifier l'agence \(agency.agenceName) "),
                      primaryButton: .default(Text("Modifier")){
                    dismiss()
                    self.name = ""
                    self.address = ""
                    self.assigneeID = ""
                    self.latitude = ""
                    self.longitude = ""
                },
                      secondaryButton: .cancel() )
            }
        }
        .onAppear {
            self.name = agency.agenceName
            self.address = agency.adresse
            self.assigneeID = agency.idHead
            self.latitude = String(agency.latitude)
            self.longitude = String(agency.longitude)
        }
    }
}


struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var address = ""
    @State private var assigneeID = ""
    @State private var latitude = ""
    @State private var longitude = ""

    let assignees = ["Mohammed", "Khaled", "Samir"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Nom de l'agence")
                    TextField("Nom de l'agence", text: $name)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    Text("Adresse de l'agence")
                    TextField("Adresse de l'agence", text: $address)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Section {
                    Picker(selection: $assigneeID, label: Text("Chef d'agence")) {
                        ForEach(0..<assignees.count) { index in
                            Text(self.assignees[index]).tag(index)
                        }
                    }
                }

                Section {
                    Text("Latitude")
                    TextField("Latitude", text: $latitude)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    Text("Longitude")
                    TextField("Longitude", text: $longitude)
                        .autocapitalization(.words)
                        .frame(height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)

                }


            }
            .navigationBarTitle("Ajouter une agence", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // Action for Cancel button
                dismiss()
                self.name = ""
                self.address = ""
                self.assigneeID = ""
                self.latitude = ""
                self.longitude = ""
            }) {
                Text("Annuler")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.red)
            })
            .navigationBarItems(trailing: Button(action: {
                // Action for Cancel button
                dismiss()
                self.name = ""
                self.address = ""
                self.assigneeID = ""
                self.latitude = ""
                self.longitude = ""
            }) {
                Text("Ajouter")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.blue)
            })
        }
    }
}

let agencies = [
    Agence(agenceName: "Agence Ariana", adresse: "30 Rue des voirures, Ariana",idHead: "1",longitude : "56,6,656",latitude: "648468,6546,66"),
    Agence(agenceName: "Agence Bardo", adresse: "50 Avenue des beaux arts, Tunis",idHead: "2",longitude : "56,6,656",latitude: "648468,6546,66"),
    Agence(agenceName: "Agence Soussa", adresse: "30 Rue des voirures, Ariana",idHead: "1",longitude : "56,6,656",latitude: "648468,6546,66"),
    Agence(agenceName: "Agence Manar", adresse: "30 Rue des voirures, Ariana",idHead: "1",longitude : "56,6,656",latitude: "648468,6546,66"),
    Agence(agenceName: "Agence Gbelli", adresse: "30 Rue des voirures, Ariana",idHead: "1",longitude : "56,6,656",latitude: "648468,6546,66"),
    Agence(agenceName: "Agence Tozer", adresse: "30 Rue des voirures, Ariana",idHead: "1",longitude : "56,6,656",latitude: "648468,6546,66"),
]

struct AgenceView_Previews: PreviewProvider {
    static var previews: some View {
        AgenceView()
    }
}
