//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 03.05.22.
//

import Foundation
import Combine

class CoinDetailDataService{
  
  @Published var coinDetail: CoinDetailModel? = nil
  var cancellable: AnyCancellable? = nil
  let coin: CoinModel
  
  init(coin: CoinModel){
    self.coin = coin
    getData()
  }
  
  func getData(){
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
    cancellable = NetworkManager.download(url: url)
      .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkManager.handleCompletion(completion:), receiveValue: { [weak self] coinData in
        self?.coinDetail = coinData
        self?.cancellable?.cancel()
      })
  
  }
}
