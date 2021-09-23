//
//  CoinModel.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 17/09/2021.
//

import Foundation

/*
 CoinGecko API Info
 --------------------------
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=myr&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
 
 JSON Response:
 {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
 "current_price": 197839,
 "market_cap": 3728602562440,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 4161017922691,
 "total_volume": 130153051354,
 "high_24h": 202003,
 "low_24h": 196848,
 "price_change_24h": -1984.427277269628,
 "price_change_percentage_24h": -0.99309,
 "market_cap_change_24h": -38802895293.93115,
 "market_cap_change_percentage_24h": -1.02996,
 "circulating_supply": 18817668,
 "total_supply": 21000000,
 "max_supply": 21000000,
 "ath": 267546,
 "ath_change_percentage": -25.9404,
 "ath_date": "2021-04-14T11:54:46.763Z",
 "atl": 211.18,
 "atl_change_percentage": 93728.70715,
 "atl_date": "2013-07-05T00:00:00.000Z",
 "roi": null,
 "last_updated": "2021-09-16T18:06:42.922Z",
 "sparkline_in_7d": {
 "price": [
 46965.17806527827,
 46704.30601005894,
 ....
 ]
 },
 "price_change_percentage_24h_in_currency": -0.9930924172043658
 },
 */

struct Coin: Codable, Identifiable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHolding: Double?
    
    func updateHolding(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: totalVolume, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHolding: amount)
    }
    
    var currentHoldingValue: Double {
        return (currentHolding ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}


struct SparklineIn7D: Codable {
    let price: [Double]?
}
