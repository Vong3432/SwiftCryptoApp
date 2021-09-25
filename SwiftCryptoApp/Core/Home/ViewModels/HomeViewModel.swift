//
//  HomeViewModel.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 18/09/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // Subscribe to CoinDataService
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubsribers()
    }
    
    func addSubsribers() {
        dataService.$allCoins.sink { [weak self] (returnCoins) in
            self?.allCoins = returnCoins
        }
        .store(in: &cancellables)
    }
    
}
