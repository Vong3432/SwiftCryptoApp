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
        // will receive updated value every time serachText or dataService.allCoins is changed
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // wait 0.5 seconds
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text:String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else { return coins }
        
        let loweredCasedText = text.lowercased()
        let filteredCoins = coins.filter { (coin) in
            return coin.name.lowercased().contains(loweredCasedText)
            || coin.symbol.lowercased().contains(loweredCasedText)
            || coin.id.lowercased().contains(loweredCasedText)
        }
        
        return filteredCoins
    }
    
}
