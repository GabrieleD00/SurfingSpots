//
//  MainUseCase.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import Combine
import Foundation

protocol MainUseCaseInterface {
    func getUpdatedTemperature() -> AnyPublisher<Int, Never>
    
    func getCities() async -> AnyPublisher<[City], Never>
}

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
