//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 16.04.22.
//

import UIKit
import Combine

class CoinImageViewModel: ObservableObject{
  @Published var image: UIImage? = nil
  @Published var isLoading = false
  private var cancellables = Set<AnyCancellable>()
  private let coinImageService: CoinImageService
  
  init(imageUrl: String){
    isLoading = true
    coinImageService = CoinImageService(imageUrl: imageUrl)
    coinImageService.$image
      .sink(receiveCompletion: { [weak self] _ in
        self?.isLoading = false
      }, receiveValue: { [weak self] image in
        self?.image = image
      })
      .store(in: &cancellables)
  }
}
