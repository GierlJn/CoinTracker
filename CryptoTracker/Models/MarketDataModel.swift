//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 19.04.22.
//

import Foundation

struct GlobalData: Codable {
  let data: MarketDataModel?
}

struct MarketDataModel: Codable{
  let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
  let marketCapChangePercentage24HUsd: Double
  
  var marketCap: String{
    if let item = totalMarketCap.first(where: {$0.key == "usd"}){
      return "\(item.value)"
    }
    return ""
  }
  
  var volume: String{
    if let item = totalVolume.first(where: {$0.key == "usd"}){
      return "\(item.value)"
    }
    return ""
  }
  
  var btcDominance: String{
    if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
      return "\(item.value.asPercentString())"
    }
    return ""
  }
}
