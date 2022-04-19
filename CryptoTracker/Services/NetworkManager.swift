//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import Foundation
import Combine

enum NetworkError: LocalizedError{
  case badURlResponse(url: URL)
  case unknown
  
  var errorDescription: String?{
    switch self{
    case .badURlResponse(let url):
      return "🔥 Bad URL Response: \(url)"
    case .unknown:
      return "⚠️ Unknown Error"
    }
  }
}

class NetworkManager{
  
  static func download(url: URL)->AnyPublisher<Data, Error>{
    URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap{ try handleUrlResponse(output: $0, url: url) }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
    guard let urlResponse = output.1 as? HTTPURLResponse, urlResponse.statusCode == 200 else { throw NetworkError.badURlResponse(url: url) }
    return output.data
  }
  
  static func handleCompletion(completion:  Subscribers.Completion<Error>){
    switch completion{
    case .finished:
      break
    case .failure(let error):
      print(String(describing: error))
    }
  }
  
}
