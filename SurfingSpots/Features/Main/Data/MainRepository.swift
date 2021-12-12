//
//  MainRepository.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import Combine
import Foundation

protocol MainRepositoryInterface {
    /**
    Returns a publisher with the latest temperature from the API
     */
    func getUpdatedTemperature() -> AnyPublisher<Int?, Never>
    /**
    Returns a publisher with the list of cities from the API
     */
    func getCities() async -> AnyPublisher<[City], NetworkError>
}

/**
 `MainRepository` is the class that takes the data from the data source and give it to the use case
 */
class MainRepository: MainRepositoryInterface {
    private let dataSource: MainDataSourceInterface = MainDataSource()
    
    func getUpdatedTemperature() -> AnyPublisher<Int?, Never> {
        dataSource.updatedTemperature
    }
    
    func getCities() async -> AnyPublisher<[City], NetworkError> {
        await dataSource.getCities()
    }
}
