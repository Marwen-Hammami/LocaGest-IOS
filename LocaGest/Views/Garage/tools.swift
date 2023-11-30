//
//  tools.swift
//  LocaGest
//
//  Created by Mac Mini 6 on 28/11/2023.
//

import SwiftUI

struct tools: View {
    @State private var tools: [Tools] = [
        Tools(id: UUID(), name: "Tool 1", marque: "aaasas",type: "aaa", prix: 50, image: "", stock: 10),
        Tools(id: UUID(), name: "Tool 2", marque: "aaasas",type: "aaa", prix: 50, image: "", stock: 10),
        Tools(id: UUID(), name: "Tool 3", marque: "aaasas",type: "aaa", prix: 50, image: "", stock: 10),
        Tools(id: UUID(), name: "Tool 4", marque: "aaasas",type: "aaa", prix: 50, image: "", stock: 10),
        Tools(id: UUID(), name: "Tool 5", marque: "aaasas",type: "aaa", prix: 50, image: "", stock: 10),
        Tools(id: UUID(), name: "Tool 6", marque: "aaasas",type: "aaa", prix: 50, image: "", stock: 10),
        
    ]
    
    var body: some View {
        NavigationView {
            List(tools, id: \.id) { tool in
                NavigationLink(destination: Tool(tool: tool)) {
                    Tool(tool: tool)
                }
            }
            .navigationBarTitle("Tools")
            .onAppear {
               
            }
        }
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        tools()
    }
}


