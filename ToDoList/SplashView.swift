//
//  SplashView.swift
//  ToDoList
//
//  Created by Kayley Chery on 8/9/23.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    @State private var size = 0.8;
    @State private var opacity = 0.5;
    var body: some View {
        if isActive{
            ContentView()
        }
        else{
            VStack{
                VStack{
                    Text("One \n Another")
                        .font(Font.custom("Baskerville-Bold", size: 80))
                        .foregroundColor(.black.opacity(0.80))
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .padding(10)
                    
                    Text("Encourage\n one another daily \n Hebrews 3:13")
                        .font(Font.custom("Baskerville-Bold", size: 40))
                        .foregroundColor(.black.opacity(0.80))
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 3)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
        }
    }
        
    
    struct SplashView_Previews: PreviewProvider {
        static var previews: some View {
            SplashView()
        }
    }
}
