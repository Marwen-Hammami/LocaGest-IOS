//
//  distributions.swift
//  LocaGest
//
//  Created by Mac Mini 2 on 30/11/2023.
//

import SwiftUI

struct distributions: View {
    var body: some View {
        
        NavigationView {
            
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10) { _ in
                        distribution()
                    }
                    
                    
                }
                .padding()
            }
            .navigationBarTitle("Distribution")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: addDist()) {
                Image(systemName: "plus")
            }
            )
            .onAppear {
                
            }
        }
        
    }
}
#Preview {
    distributions()
}
