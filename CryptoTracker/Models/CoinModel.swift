//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 14.04.22.
//

import Foundation


struct CoinModel: Identifiable, Codable, Equatable {
  static func == (lhs: CoinModel, rhs: CoinModel) -> Bool {
    lhs.id == rhs.id
    
  }
  
  let id, symbol, name: String
  let image: String
  let currentPrice: Double?
  let marketCap, marketCapRank, fullyDilutedValuation: Double?
  let totalVolume, high24H, low24H: Double?
  let priceChange24H: Double?
  let priceChangePercentage24H: Double?
  let marketCapChange24H: Double?
  let marketCapChangePercentage24H: Double?
  let circulatingSupply, totalSupply, maxSupply, ath: Double?
  let athChangePercentage: Double?
  let athDate: String?
  let atl, atlChangePercentage: Double?
  let atlDate: String?
  let lastUpdated: String?
  let sparklineIn7D: SparklineIn7D?
  let priceChangePercentage24HInCurrency: Double?
  private(set) var currentHoldings: Double?
  

  
  var wrappedPriceChangePercentage24H: Double{
    priceChangePercentage24H ?? 0
  }
  
  var wrappedCurrentPrice: Double{
    currentPrice ?? 0
  }
  
  mutating func updateHoldings(amount: Double) -> CoinModel {
    self.currentHoldings = amount
    return self
  }
  
  var currentHoldingsValue: Double {
    return (currentHoldings ?? 0) * wrappedCurrentPrice
  }
  
  var wrappedCurrentHoldings: Double{
    currentHoldings ?? 0
  }
  
  var rank: Int {
    return Int(marketCapRank ?? 0)
  }
  
}
struct SparklineIn7D: Codable {
  
  let price: [Double]?
}
