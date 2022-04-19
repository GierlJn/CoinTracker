//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import Foundation
import Combine

class MarketDataService{
  
  @Published var marketData: MarketDataModel?
  var cancellable: AnyCancellable?
  
  init(){
    getData()
  }
  
  var decoder: JSONDecoder{
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
  
  func getData(){
    guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
    
    cancellable = NetworkManager.download(url: url)
      .decode(type: GlobalData.self, decoder: decoder)
      .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] globalData in
        self?.marketData = globalData.data
        self?.cancellable?.cancel()
      })
  }
}
