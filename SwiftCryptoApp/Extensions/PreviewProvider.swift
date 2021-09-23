//
//  PreviewProvider.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 18/09/2021.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {} // prevent other to init a new instance of this class
    
    let coin = Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 197839, marketCap: 3728602562440, marketCapRank: 1, fullyDilutedValuation: 4161017922691, totalVolume: 130153051354, high24H: 202003, low24H: 196848, priceChange24H: -1984.427277269628, priceChangePercentage24H: -0.99309, marketCapChange24H: -38802895293.93115, marketCapChangePercentage24H: -1.02996, circulatingSupply: 18817668, totalSupply: 21000000, maxSupply: 21000000, ath: 267546, athChangePercentage: -25.9404, athDate: "2021-04-14T11:54:46.763Z", atl: 211.18, atlChangePercentage: 93728.70715, atlDate: "2013-07-05T00:00:00.000Z", lastUpdated: "2021-09-16T18:06:42.922Z", sparklineIn7D: SparklineIn7D(price: [
        46965.17806527827,
        46704.30601005894,
    ]), priceChangePercentage24HInCurrency: -0.9930924172043658, currentHolding: 1.5)
    
    let homeVM = HomeViewModel()
}

