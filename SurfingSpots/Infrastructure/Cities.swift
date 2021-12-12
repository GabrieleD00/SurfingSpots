//
//  Cities.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 12/12/21.
//

import Foundation

/**
 This layer is needed to decode the data from the api
 */
struct Cities: Codable {
    var cities: [City]
}
