//
//  distribution.swift
//  LocaGest
//
//  Created by Mac Mini 2 on 30/11/2023.
//

import SwiftUI

struct distribution: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image("Peugeot-206")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Peugeot-206+")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("Technicien:")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("chokri ben jalloul")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Text("date d'entrée:")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("26/05/2019")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        
                    }) {
                        HStack {
                            Text("livrer la voiture")
                                .fontWeight(.medium)
                                .padding(.leading, 9)
                                .padding(.vertical, 6)
                                .foregroundColor(Color.white)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                                .background(RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.black))
                                .padding(.horizontal, 28)
                        }
                        
                        
                        
                        
                    }
                }
            }
            .padding()
            .background(Color.green)
        }
    }
}

#Preview {
    distribution()
}
