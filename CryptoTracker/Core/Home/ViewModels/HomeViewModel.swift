//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject{
  @Published var showPortfolio =  true
  @Published var allCoins = [CoinModel]()
  @Published var portfolioCoins = [CoinModel]()
  @Published var searchText = ""
  @Published var statistics: [StatisticModel] = [
    StatisticModel(title: "Title", value: "$12B", percentageChange: 2),
    StatisticModel(title: "Title", value: "$12B"),
    StatisticModel(title: "Title", value: "$12B", percentageChange: 1),
    StatisticModel(title: "Title", value: "$12B", percentageChange: 4)
  ]
  @Published var marketData: MarketDataModel?
  
  private var cancellables = Set<AnyCancellable>()
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  var page = 1
  
  init(){
    fetchMarketData()
    fetchCoins()
  }
  
  func fetchMarketData(){
    marketDataService.$marketData
      .map{ (marketDataModel) -> [StatisticModel] in
        var stats = [StatisticModel]()
        guard let data = marketDataModel else { return stats }
        stats = [
          StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd),
          StatisticModel(title: "24h Volume", value: data.volume),
          StatisticModel(title: "BTC Docminance", value: data.btcDominance),
          StatisticModel(title: "Portfolio Value", value: "$0.0", percentageChange: 0)
        ]
        return stats
      }
      .sink(receiveValue: { [weak self] receivedStatistics in
        self?.statistics = receivedStatistics
      })
      .store(in: &cancellables)
  }
  
  func fetchCoins(){
    $searchText
      .combineLatest(coinDataService.$allCoins)
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
  }
  
  private func filterCoins(inputString: String, coinArray: [CoinModel]) -> [CoinModel]{
    guard !inputString.isEmpty else {  return coinArray }
    let inputString = inputString.lowercased()
    return coinArray.filter { coin in
      return coin.name.lowercased().contains(inputString) ||
      coin.id.lowercased().contains(inputString) ||
      coin.symbol.lowercased().contains(inputString)
    }
  }
  
}
