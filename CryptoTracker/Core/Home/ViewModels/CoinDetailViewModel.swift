//
//  CoinDetailViewModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 03.05.22.
//

import Foundation
import SwiftUI
import Combine

class CoinDetailViewModel: ObservableObject{
  
  @Published var description: Description? = nil
  @Published var links: Links? = nil
  private var cancellabes = Set<AnyCancellable>()
  let dataService: CoinDetailDataService
  
  init(coin: CoinModel){
    self.dataService = CoinDetailDataService(coin: coin)
    fetchData()
  }
  
  func fetchData(){
    dataService.$coinDetail
      .sink(receiveValue: { [weak self] coinDetail in
        self?.links = coinDetail?.links
        self?.description = coinDetail?.description
      })
      .store(in: &cancellabes)
  }
}
