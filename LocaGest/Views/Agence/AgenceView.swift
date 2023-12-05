import SwiftUI

struct AgenceView: View {
    @StateObject var agenceViewModel = AgenceViewModel()
    @State private var showForm = false

    @Environment(\.dismiss) var dismiss
    
    @State private var searchText: String = ""
    @State private var isSubmissionSuccessful = false
    @State private var    showAlertUpdate  = true

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search...", text: $searchText)
                                .padding(7)
                                .padding(.horizontal, 25)
                               .background(Color(.systemGray6))
                               .cornerRadius(8)
                
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                   .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(3)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                
                if let agences = agenceViewModel.agences {
                    List(agences.filter { agency in
                        searchText.isEmpty ? true : agency.agenceName.localizedCaseInsensitiveContains(searchText)
                    }) { agency in
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
                } else {
                    // Show loading indicator or error message
                    ProgressView()
                        .onAppear {
                            agenceViewModel.fetchAgencess()
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
        .onAppear {
            agenceViewModel.fetchAgencess()
        }
    }
    
}

struct DetailView: View {
    let agency: Agence
    @Environment(\.dismiss) var dismiss
    let agenceService = AgenceService.shared
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
                    Text(agency.idHead ?? "0")
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
                            agenceService.deleteAgence(agencyID: agency.id) { error in
                                                            if let error = error {
                                                                // Handle deletion error if needed
                                                                print("Error deleting agency: \(error)")
                                                            } else {
                                                                
                                                                // Handle successful deletion if needed
                                                            }
                                                        }
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
    let agenceService = AgenceService.shared // Accessing the shared instance of AgenceService

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
                    let json: [String: Any] = [
                        "_id": agency.id,
                        "AgenceName": self.name,
                        "Adresse": self.address,
                        "IdHead": "555",
                        "longitude": Double(self.longitude) ?? 0.0,
                        "latitude":   Double(self.latitude) ?? 0.0
                    ]
                    print(json)

                    
                    if let agence = Agence(json: json) {
                        agenceService.updateAgence(agencyID: agency.id, updatedData: agence) { error in
                            if let error = error {
                                // Handle update error if needed
                                print("Error updating agency: \(error)")
                            } else {
                                // Update successful
                            }
                        }
                    } else {
                        // Handle case where Agence object couldn't be created from JSON
                        print("Failed to create Agence object from JSON")
                    }
                },
                      secondaryButton: .cancel() )
            }
        }
        .onAppear {
            self.name = agency.agenceName
            self.address = agency.adresse
            self.assigneeID = "agency.idHead"
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
                addAgence()
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
    func addAgence() {
        // Define the API endpoint URL
        let apiUrlString = "http://172.20.10.12:9090/agence/new/"
        
        // Create the URL
        guard let url = URL(string: apiUrlString) else {
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request body
        let requestBody: [String: Any] = [
            "AgenceName": name,
            "Adresse": address,
            "IdHead": assigneeID,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        do {
            // Convert the request body to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            return
        }
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error adding agence: \(error)")
                
                return
            }
            
            // Check for a successful HTTP response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                
            } else {
                dismiss()
               // Agence addition failed
                
            }
        }.resume()
    }
    
    
    
    struct FormView: View {
        @Environment(\.dismiss) var dismiss
        @State private var name = ""
        @State private var address = ""
        @State private var assigneeID = ""
        @State private var latitude = ""
        @State private var longitude = ""
        @State private var showAlertUpdate: Bool = false // Ajout de la variable showAlertUpdate
        let agenceService = AgenceService.shared // Accessing the shared instance of AgenceService
        let assignees = ["Mohammed", "Khaled", "Samir"]
        var agency: Agence // Ajout de la propriété agency pour la vue
        
        var body: some View {
            NavigationView {
                Form {
                    // Vos sections existantes pour la modification de l'agence
                }
                .navigationBarTitle("Modifier une agence", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
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
                    },
                    trailing: Button(action: {
                        // Action for Modifier button
                        showAlertUpdate = true
                    }) {
                        Text("Modifier")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.blue)
                    }
                )
                .alert(isPresented: $showAlertUpdate){
                    Alert(title: Text("Êtes-vous sûrs?"), message: Text("Êtes-vous sûrs de vouloir modifier l'agence \(agency.agenceName) "),
                          primaryButton: .default(Text("Modifier")){
                        let json: [String: Any] = [
                            "_id": agency.id,
                            "AgenceName": self.name,
                            "Adresse": self.address,
                            "IdHead": "555",
                            "longitude": self.longitude,
                            "latitude":  self.latitude
                        ]

                        if let agence = Agence(json: json) {
                            agenceService.updateAgence(agencyID: agency.id, updatedData: agence) { error in
                                if let error = error {
                                    // Handle update error if needed
                                    print("Error updating agency: \(error)")
                                } else {
                                    dismiss()
                                    // Update successful
                                }
                            }
                        } else {
                            // Handle case where Agence object couldn't be created from JSON
                            print("Failed to create Agence object from JSON")
                        }
                    },
                          secondaryButton: .cancel() )
                }
            }
            .onAppear {
                self.name = agency.agenceName
                self.address = agency.adresse
                self.assigneeID = agency.idHead ?? ""
                self.latitude = String(agency.latitude)
                self.longitude = String(agency.longitude)
            }
        }
        
        
        
        func updateAgence() {
            // Define the API endpoint URL for updating an agency, assuming the agency ID is available
            let id = "YOUR_AGENCY_ID" // Remplacez ceci par l'ID réel de l'agence que vous souhaitez mettre à jour
            let apiUrlString = "http://172.20.10.12:9090/agence/:id/" // Utilisez l'URL avec l'ID de l'agence
            
            // Create the URL
            guard let url = URL(string: apiUrlString) else {
                return
            }
            
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "PUT" // Utilisez PUT, PATCH ou la méthode HTTP appropriée pour la mise à jour
            
            // Set the Content-Type header
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Create the request body
            let requestBody: [String: Any] = [
                "AgenceName": name,
                "Adresse": address,
                "IdHead": assigneeID,
                "latitude": latitude,
                "longitude": longitude
            ]
            
            do {
                // Convert the request body to JSON data
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                return
            }
            
            // Perform the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error updating agence: \(error)")
                    return
                }
                
                // Check for a successful aHTTP response
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    // Agence updated successfully
                    // You might want to handle the updated data or UI changes here if needed
                } else {
                    // Agence update failed
                    // You can handle the failure scenario here
                }
            }.resume()
        }
        
    }
    
    struct DetailView: View {
        let agency: Agence
        @Environment(\.dismiss) var dismiss
        @State private var showAlert: Bool = false
        let agenceService = AgenceService.shared // Accessing the shared instance of AgenceService

        var body: some View {
            VStack(alignment: .center) {
                // ... Other elements in your DetailView
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Êtes-vous sûrs?"), message: Text("Êtes-vous sûrs de vouloir supprimer l'agence \(agency.agenceName) "),
                              primaryButton: .destructive(Text("Supprimer")){
                                agenceService.deleteAgence(agencyID: agency.id) { error in
                                    if let error = error {
                                        // Handle deletion error if needed
                                        print("Error deleting agency: \(error)")
                                    } else {
                                        dismiss()
                                        // Handle successful deletion if needed
                                    }
                                }
                              },
                              secondaryButton: .cancel()
                        )
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle(agency.agenceName, displayMode: .inline)
        }
    }

        
    

}


struct AgenceView_Previews: PreviewProvider {
    static var previews: some View {
        AgenceView()
    }
}


