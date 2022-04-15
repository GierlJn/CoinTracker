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
  
  private var cancellables = Set<AnyCancellable>()
  private let dataService = CoinDataService()
  var page = 1
  
//  @MainActor func fetchAllCoins() async{
//    do{
//      let newCoins = try await ApiService.shared.fetchCoins(page: page)
//      allCoins.append(contentsOf: newCoins)
//      page += 1
//    }catch{
//      fatalError("not fetched")
//    }
//  }
  
  init(){
    fetchCoins()
  }
  
  func fetchCoins(){
    dataService.$allCoins
      .sink { [unowned self] coins in
        allCoins = coins
      }
      .store(in: &cancellables)
    
  }
  
}
