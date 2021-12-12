//
//  CityCard.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 10/12/21.
//

import SwiftUI

struct CityCard: View {
    let city: City

    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(city.name)
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 8)
                    
                    Text("\(city.weatherConditions.rawValue) - \(city.temperature) degrees")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0))
            .zIndex(1)
            
            if city.weatherConditions == .sunny {
                city.image
                    .resizable()
                    .frame(height: 200)
                    .cornerRadius(16)
            } else {
                Color.black
                    .opacity(0.7)
                    .frame(height: 200)
                    .cornerRadius(16)
            }
        }
        .padding(.horizontal, 16)
    }
}

struct CityCard_Previews: PreviewProvider {
    static var previews: some View {
        CityCard(city: City(name: "Los Angeles"))
    }
}
