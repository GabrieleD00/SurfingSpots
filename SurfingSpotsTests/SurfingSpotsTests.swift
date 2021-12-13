//
//  SurfingSpotsTests.swift
//  SurfingSpotsTests
//
//  Created by Gabriele Diletto on 10/12/21.
//

import Combine
import XCTest
@testable import SurfingSpots

class SurfingSpotsTests: XCTestCase {
    private var disposables = Set<AnyCancellable>()

    func testGetUpdatedTemperature() {
        let useCase = MainUseCase()

        useCase.getUpdatedTemperature()
            .first()
            .sink { newValue in
                XCTAssertTrue(newValue > 0 && newValue < 60)
            }
            .store(in: &disposables)
    }

    func testGetCities() {
        let useCase = MainUseCase()

        Task {
            await useCase.getCities()
                .sink(receiveValue: { [weak self] cities in
                    guard let self = self else { return }
                    
                    var unsortedCities = cities
                    unsortedCities.sort(by: {$0.temperature > $1.temperature})
                    
                    XCTAssertTrue(self.sortedCities() == unsortedCities)
                })
                .store(in: &disposables)
        }
    }

    private func sortedCities() -> [City] {
        return [
            City(name: "Riccione", temperature: 60),
            City(name: "Ortona", temperature: 50),
            City(name: "Midgar", temperature: 40),
            City(name: "Porto", temperature: 30),
            City(name: "Miami", temperature: 20),
            City(name: "Cuba", temperature: 10),
            City(name: "Los Angeles", temperature: 0)
        ]
    }
}
