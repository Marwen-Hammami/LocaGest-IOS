import SwiftUI

struct SplashScreen: View {
    @State private var animate = false
    
    var body: some View {
        VStack {
            Image("logo") // Replace "yourImageName" with your image name or URL
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(animate ? 1.2 : 1.0) // Apply scale effect when animating
            
            Text("LocaGest")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
                .opacity(animate ? 1.0 : 0.0) // Fade in text when animating
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                animate = true // Trigger animation on view appear
            }
        }
    }
}
