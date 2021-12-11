//
//  MainView.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 10/12/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            VStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 0) {
                    Text("Surfing Spots")
                        .font(.largeTitle)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 0))
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.5))
            }
            .frame(height: 100)
            .background(Color.gray.opacity(0.15))
            .padding(.bottom, 24)
            
            
            
            ScrollView {
                ForEach(0..<4) { _ in
                    CityCard()
                        .padding(.bottom, 8)
                }
            }
            .background(Color.white)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
