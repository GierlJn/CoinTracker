//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import Foundation
import Combine

class CoinDataService{
  
  @Published var allCoins = [CoinModel]()
  var cancellable: AnyCancellable?
  
  init(){
    getCoins()
  }
  
  var decoder: JSONDecoder{
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
  
  func getCoins(){
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    
    cancellable = NetworkManager.download(url: url)
      .decode(type: [CoinModel].self, decoder: decoder)
      .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [unowned self] coins in
        self.allCoins = coins
        self.cancellable?.cancel()
      })
  }
}
