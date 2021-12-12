//
//  City.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import SwiftUI
import Foundation

/**
 Defines the model used to represent a city
 */
struct City: Identifiable, Codable {
    let id = UUID()
    var name: String
    var temperature = Int.random(in: 0...60)
    
    var weatherConditions: WeatherConditions {
        if temperature >= 30 {
            return .sunny
        } else {
            return .cloudy
        }
    }
    
    var image: Image {
        return Image(name, bundle: .main)
    }

    enum CodingKeys: CodingKey {
        case name
    }
}
