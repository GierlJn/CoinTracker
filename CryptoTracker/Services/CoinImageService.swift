//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 16.04.22.
//

import UIKit
import Combine

class CoinImageService{
  
  @Published var image: UIImage? = nil
  var cancellable: AnyCancellable?
  
  init(imageUrl: String){
    getImage(imageUrl)
  }
  
  private func getImage(_ url: String){
    guard let url = URL(string: url) else { return }
    
    if let image = ImageCache[url]{
      self.image = image
      return
    }
    
    cancellable = NetworkManager.download(url: url)
      .tryMap { data in
        UIImage(data: data)
      }
      .sink(receiveCompletion: NetworkManager.handleCompletion) { [unowned self] image in
        self.image = image
        ImageCache[url] = image
        self.cancellable?.cancel()
      }
  }
}

fileprivate class ImageCache {
    static private var cache: [URL: UIImage] = [:]

    static subscript(url: URL) -> UIImage? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
