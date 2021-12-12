//
//  MainViewModel.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 12/12/21.
//

import Combine
import SwiftUI
import Foundation

/**
 `MainViewModel` is the class responsible for updating the UI and managing the UX
 */
class MainViewModel: ObservableObject {
    @Published var cities: [City] = []
    
    private let useCase: MainUseCaseInterface = MainUseCase()
    private var disposables = Set<AnyCancellable>()

    init() {
        Task {
            await useCase.getCities()
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] newValues in
                    guard let self = self else { return }
                    
                    self.cities = newValues
                    
                    withAnimation(.linear(duration: 0.5)) {
                        self.cities.sort(by: { $0.temperature > $1.temperature })
                    }
                })
                .store(in: &disposables)
        }
        
        useCase.getUpdatedTemperature()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTemperature in
                guard let self = self else { return }
                
                self.updateRandomCity(newTemperature: newTemperature)
            }
            .store(in: &disposables)
    }
    
    /**
     Updates the temperature of a random city
     
     - Parameter newTemperature: the latest temperature from the API
     */
    private func updateRandomCity(newTemperature: Int) {
        if cities.isEmpty { return }
        
        let randomIndex = Int.random(in: cities.indices)
        
        cities[randomIndex].temperature = newTemperature
        
        withAnimation(.linear(duration: 0.5)) {
            cities.sort(by: { $0.temperature > $1.temperature })
        }
    }
    
}
