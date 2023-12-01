//
//  Link.swift
//  LocaGest
//
//  Created by Mac Mini 2 on 1/12/2023.
//

import SwiftUI

struct Link: View {
 
        var body: some View {
            NavigationView {
                VStack(spacing: 16) {
                    NavigationLink(destination: tools()) {
                        Text("Go to Tools")
                            .fontWeight(.medium)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    NavigationLink(destination: distributions()) {
                        Text("Go to Distribution")
                            .fontWeight(.medium)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .navigationTitle("Main Menu")
            }
        }
    }

    struct ToolsView: View {
        var body: some View {
            Text("Tools View")
                .font(.title)
                .padding()
        }
    
}

#Preview {
    Link()
}
