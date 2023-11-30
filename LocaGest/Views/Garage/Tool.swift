import SwiftUI

struct Tool: View {
    let tool: Tools
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image("wrench_7185363")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(tool.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("Marque:")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(tool.marque)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Text("Type:")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(tool.type)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Text("Prix:")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("\(tool.prix)€")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Text("Stock:")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("\(tool.stock)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .background(Color.green)
    }
}


struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTool = Tools(id: UUID(),
                               name: "Mofte7",
                               marque: "Sippon",
                               type: "Type de l'outil",
                               prix: 50,
                               image: "tool_image",
                               stock: 10)
        
        Tool(tool: sampleTool)
    }
}

