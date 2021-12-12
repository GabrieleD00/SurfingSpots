//
//  MainRepository.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import Combine
import Foundation

protocol MainRepositoryInterface {
    func getUpdatedTemperature() -> AnyPublisher<Int?, Never>
    
    func getCities() async -> AnyPublisher<[City], NetworkError>
}


class MainRepository: MainRepositoryInterface {
    private let dataSource: MainDataSourceInterface = MainDataSource()
    
    func getUpdatedTemperature() -> AnyPublisher<Int?, Never> {
        dataSource.updatedTemperature
    }
    
    func getCities() async -> AnyPublisher<[City], NetworkError> {
        await dataSource.getCities()
    }
}
