//
//  MainUseCase.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import Combine
import Foundation

protocol MainUseCaseInterface {
    /**
    Returns a publisher with the latest temperature from the API
     */
    func getUpdatedTemperature() -> AnyPublisher<Int, Never>
    /**
    Returns a publisher with the list of cities from the API
     */
    func getCities() async -> AnyPublisher<[City], Never>
}

/**
 `MainUseCase` is the class that prepares the data to be used by the view model
 */
class MainUseCase: MainUseCaseInterface {
    private let repo: MainRepositoryInterface = MainRepository()
    
    func getUpdatedTemperature() -> AnyPublisher<Int, Never> {
        repo.getUpdatedTemperature()
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    func getCities() async -> AnyPublisher<[City], Never> {
        await repo.getCities()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
