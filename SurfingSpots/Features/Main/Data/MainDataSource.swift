//
//  MainDataSource.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 11/12/21.
//

import Combine
import Foundation

protocol MainDataSourceInterface {
    var updatedTemperature: AnyPublisher<Int?, Never> { get }
    
    func getCities() async -> AnyPublisher<[City], NetworkError>
}

enum NetworkError: Error {
    case emptyData
    case dataNotRight
}

/**
 `MainData`
 */
class MainDataSource: MainDataSourceInterface {
    private let citiesUrl = URL(string: "https://run.mocky.io/v3/652ceb94-b24e-432b-b6c5-8a54bc1226b6")
    private let temperaturesUrl = URL(string: "http://numbersapi.com/random?min=0&max=60")
    private let decoder = JSONDecoder()
    
    private let temperatureSubject = PassthroughSubject<Int?, Never>()
    
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
    
    var updatedTemperature: AnyPublisher<Int?, Never> {
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
     - Parameter url: url
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
