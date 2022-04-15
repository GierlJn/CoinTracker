//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import SwiftUI

class HomeViewModel: ObservableObject{
  @Published var showPortfolio =  true
  @Published var allCoins = [CoinModel]()
 	@Published var portfolioCoins = [CoinModel]()
  
  var page = 1
  
  @MainActor func fetchAllCoins() async{
    do{
      let newCoins = try await ApiService.shared.fetchCoins(page: page)
      allCoins.append(contentsOf: newCoins)
      page += 1
    }catch{
      fatalError("not fetched")
    }
    
  }
}
