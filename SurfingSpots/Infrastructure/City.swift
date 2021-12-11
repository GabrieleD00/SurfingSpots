//
//  City.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import Foundation

struct City: Identifiable, Codable {
    let id = UUID()
    var name: String
    var temperature = Int.random(in: 0...60)
    
    enum CodingKeys: CodingKey {
        case name
    }
}
