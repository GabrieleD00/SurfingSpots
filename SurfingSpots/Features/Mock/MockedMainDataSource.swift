//
//  MockedMainDataSource.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 13/12/21.
//

import Combine
import Foundation

class MockedMainDataSource: MainDataSourceInterface {
    func getUpdatedTemperature() -> AnyPublisher<Int?, Never> {
        Timer.publish(every: 3, on: RunLoop.current, in: .default)
            .map { _ in
                return Int.random(in: 0...60)
            }
            .eraseToAnyPublisher()
    }
    
    func getCities() async -> AnyPublisher<[City], NetworkError> {
        return Just(mockedCities()).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    private func mockedCities() -> [City] {
        return [
            City(name: "Cuba", temperature: 10),
            City(name: "Los Angeles", temperature: 0),
            City(name: "Miami", temperature: 20),
            City(name: "Porto", temperature: 30),
            City(name: "Ortona", temperature: 50),
            City(name: "Riccione", temperature: 60),
            City(name: "Midgar", temperature: 40)
        ]
    }
}
