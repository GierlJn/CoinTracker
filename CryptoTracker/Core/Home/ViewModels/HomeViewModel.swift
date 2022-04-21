//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import SwiftUI
import Combine

enum SortOption {
  case rank, rankReversed, holding, holdingReversed, price, priceReversed
}

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
  @Published var sortOption: SortOption = .holding
  
  private var cancellables = Set<AnyCancellable>()
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  var page = 1
  
  init(){
    fetchMarketData()
    fetchCoins()
    fetchPortfolio()
  }
  
  func updateCoins(){
    coinDataService.getCoins()
    marketDataService.getData()
  }
  
  func fetchMarketData(){
    marketDataService.$marketData
      .combineLatest($portfolioCoins)
      .map{ (marketDataModel, portfolioCoins) -> [StatisticModel] in
        var stats = [StatisticModel]()
        guard let data = marketDataModel else { return stats }
        
        let portfolioSum = portfolioCoins.reduce(0) { partialResult, coin in
          coin.currentHoldingsValue + partialResult
        }
        
        let previousValue = portfolioCoins.map { coin -> Double in
          let currentValue = coin.currentHoldingsValue
          let percentageChange = coin.wrappedPriceChangePercentage24H / 100
          return currentValue / (1 + percentageChange)
        }
          .reduce(0, +)
        
        let percentageChange = ((portfolioSum - previousValue) / previousValue)
        
        stats = [
          StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd),
          StatisticModel(title: "24h Volume", value: data.volume),
          StatisticModel(title: "BTC Docminance", value: data.btcDominance),
          StatisticModel(title: "Portfolio Value", value: "$\(portfolioSum.asUsd2Decimal())", percentageChange: percentageChange)
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
      .combineLatest(coinDataService.$allCoins, $sortOption)
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .map(filterAndSortCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
  
  func fetchPortfolio(){
    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map{ (coinModels, portfolioEntities) -> [CoinModel] in
        coinModels
          .compactMap { coin -> CoinModel? in
          guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id} ) else { return nil }
          var coin = coin
          return coin.updateHoldings(amount: entity.amount)
          }
      }
      .sink { [weak self] returnedCoins in
        self?.portfolioCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double){
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  private func filterAndSortCoins(inputString: String, coinArray: [CoinModel], sortOption: SortOption) -> [CoinModel]{
    let filtered = filterCoins(inputString: inputString, coinArray: coinArray)
    switch sortOption {
    case .rank:
      return filtered.sorted(by: {$0.rank > $1.rank})
    case .rankReversed:
      return filtered.sorted(by: {$0.rank < $1.rank})
    case .holding:
      return filtered.sorted(by: {$0.wrappedCurrentHoldings > $1.wrappedCurrentHoldings})
    case .holdingReversed:
      return filtered.sorted(by: {$0.wrappedCurrentHoldings < $1.wrappedCurrentHoldings})
    case .price:
      return filtered.sorted(by: {$0.wrappedCurrentPrice > $1.wrappedCurrentPrice})
    case .priceReversed:
      return filtered.sorted(by: {$0.wrappedCurrentPrice > $1.wrappedCurrentPrice})
    }
  }
  
  private func filterCoins(inputString: String, coinArray: [CoinModel]) -> [CoinModel]{
    guard !inputString.isEmpty else {  return coinArray }
    let inputString = inputString.lowercased()
    let filtered = coinArray.filter { coin in
      return coin.name.lowercased().contains(inputString) ||
      coin.id.lowercased().contains(inputString) ||
      coin.symbol.lowercased().contains(inputString)
    }
    return filtered
  }
}
