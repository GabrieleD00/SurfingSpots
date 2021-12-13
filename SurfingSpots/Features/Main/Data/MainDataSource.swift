//
//  MainDataSource.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import Combine
import Foundation

/**
 Defines the functions that the data source should implement
 */
protocol MainDataSourceInterface {
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
 Defines the possible error given by the url request
 */
enum NetworkError: Error {
    case emptyData
    case dataNotRight
}

/**
 `MainDataSource` is the class that manages to get the latest data from the API using the functions declared in MainDataSourceInterface
 */
class MainDataSource: MainDataSourceInterface {
    private let temperatureSubject = PassthroughSubject<Int?, Never>()
    private let citiesUrl = URL(string: "https://run.mocky.io/v3/652ceb94-b24e-432b-b6c5-8a54bc1226b6")

    /*
     I used a url with a specific range (0...60) to make the data more realistic
     The original link is http://numbersapi.com/random/math
     */
    private let temperaturesUrl = URL(string: "http://numbersapi.com/random?min=0&max=60")
    private let decoder = JSONDecoder()

    init() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            Task { [weak self] in
                guard let self = self else { return }
                
                guard let newTemperature = await self.getUpdatedTemperature() else {
                    self.temperatureSubject.send(nil)
                    return
                }

                self.temperatureSubject.send(newTemperature)
            }
        }
    }
    
    func getUpdatedTemperature() -> AnyPublisher<Int?, Never> {
        return temperatureSubject.eraseToAnyPublisher()
    }
    
    func getCities() async -> AnyPublisher<[City], NetworkError> {
        let data = await getData(url: citiesUrl)
        
        guard let data = data else {
            return Fail(error: NetworkError.emptyData).eraseToAnyPublisher()
        }
        
        do {
            let cities = try self.decoder.decode(Cities.self, from: data)
            
            return Just(cities.cities).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        } catch(let error) {
            print(error.localizedDescription)
            return Fail(error: NetworkError.dataNotRight).eraseToAnyPublisher()
        }
    }
    
    /**
    Returns the latest temperature from the API
     */
    private func getUpdatedTemperature() async -> Int? {
        let data = await getData(url: temperaturesUrl)
        
        guard let data = data else {
            return nil
        }
        
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        let splittedString = string.split(separator: " ").map { String($0) }

        let newTemperature = splittedString.compactMap { Int($0) }.first
        
        return newTemperature
    }
    
    /**
     Returns the data retrieved from the given url

     - Parameter url: the url where the data comes from
     */
    private func getData(url: URL?) async -> Data? {
        guard let url = url else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return data
        } catch(let error) {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
