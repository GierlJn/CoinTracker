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
  
  func getCoins(){
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap({ (output) -> Data in
        guard let urlResponse = output.1 as? HTTPURLResponse, urlResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
        return output.data
      })
      .receive(on: DispatchQueue.main)
      .decode(type: [CoinModel].self, decoder: JSONDecoder())
      .sink(receiveCompletion: { completion in
        switch completion{
        case .finished:
          break
        case .failure(let error):
          print(error.localizedDescription)
        }
      }, receiveValue: { [unowned self] coins in
        self.allCoins = coins
        self.cancellable?.cancel()
      })
  }
}
