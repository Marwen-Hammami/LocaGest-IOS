//
//  NavigationStack.swift
//  LocaGest
//
//  Created by Karim Hammami on 24/11/2023.
//

import SwiftUI

struct NavigationStack: View {
    var body: some View {
        
        VStack {
            NavigationLink("This is screen number 1") {
                Text("Go to screen 1")
            }
            Spacer().frame(height: 10)
            NavigationLink("This is screen number 2") {
                Text("Go to screen 2")
            }
            Spacer().frame(height: 10)
            NavigationLink("This is screen number 3") {
                Text("Go to screen 3")
            }
            Spacer().frame(height: 10)
            NavigationLink("This is screen number 4") {
                Text("Go to screen 4")
            }
            Spacer().frame(height: 10)
            NavigationLink("This is screen number 5") {
                Text("Go to screen 5")
            }
            
        }
          
    }
}

struct NavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack()
    }
}
