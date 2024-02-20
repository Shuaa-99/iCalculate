//
//  SplashScreen.swift
//  iCalculate
//
//  Created by SHUAA on 7.2.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isLoading = false
    @State var isActive: Bool = false
    var body: some View {
        
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                // Your splash screen content
                VStack {
                    Image("splashImg")
                        .resizable()
                        .frame(width: 200,height: 100)
                        .foregroundColor(.white)
                        .opacity(isLoading ? 1 : 0) // Initially hidden
                }
                
                .onAppear {
                    // Trigger the animation when the view appears
                    withAnimation(.easeIn(duration: 2)) {
                        isLoading = true // Set isLoading to true to trigger animation
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isActive = true
                            
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    SplashScreen()
}
