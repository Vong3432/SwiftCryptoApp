//
//  CoinDataService.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 18/09/2021.
//

import Foundation
import Combine
class CoinDataService {
    
    // To publish data to its subscribers every times it updated
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=myr&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                
                // since the request is a simple GET request, unlike some real-time request
                // hence, when it comes back at the first time, we cancel it.
                self?.coinSubscription?.cancel()
            })
        
    }
}
