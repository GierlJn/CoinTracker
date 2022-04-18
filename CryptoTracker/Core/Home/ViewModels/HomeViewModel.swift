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
  
  private var cancellables = Set<AnyCancellable>()
  private let dataService = CoinDataService()
  var page = 1
  
  init(){
    fetchCoins()
  }
  
  func fetchCoins(){
    $searchText
      .combineLatest(dataService.$allCoins)
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
