//
//  CityCard.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 10/12/21.
//

import SwiftUI

struct CityCard: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Los Angeles")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 8)
                    
                    Text("Sunny - 38 degrees")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0))
            .zIndex(1)
            
            
            Image("Los Angeles", bundle: .main)
                .resizable()
                .frame(height: 200)
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
    }
}

struct CityCard_Previews: PreviewProvider {
    static var previews: some View {
        CityCard()
    }
}
