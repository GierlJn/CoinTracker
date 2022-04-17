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
  
  init(coin: CoinModel){
    getImage(coin)
  }
  
  private func getImage(_ coin: CoinModel){
    guard let url = URL(string: coin.image) else { return }
    
    //if let image = ImageCache[url]{
    if let image = LocalFileManager.shared.getImage(folderName: "cachedImages", imageName: coin.name){
      self.image = image
      return
    }
    
    cancellable = NetworkManager.download(url: url)
      .tryMap { data in
        UIImage(data: data)
      }
      .sink(receiveCompletion: NetworkManager.handleCompletion) { [unowned self] image in
        self.image = image
        //ImageCache[url] = image
        LocalFileManager.shared.saveImage(folderName: "cachedImages", imageName: coin.name, image: image!)
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
