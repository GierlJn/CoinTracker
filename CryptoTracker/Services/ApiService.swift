//
//  ApiService.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import Foundation

enum ApiError: String, Error{
  case fetchError = "Failed fetching data"
  case urlError = "URL not valid"
  case returnCodeNotValid = "retur Code Not Valid"
}

class ApiService{
  
  static let shared = ApiService()
  private init(){}
  
  let baseUrl = "https://api.coingecko.com/api/v3/"
  
  var decoder: JSONDecoder{
    let decoder = JSONDecoder()
    return decoder
  }
  
  func fetchCoins(page: Int, urlSession: URLSession = URLSession.shared) async throws -> [CoinModel]{
    let endpoint = "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=\(page)&sparkline=true&price_change_percentage=24h"
    
    guard let url = URL(string: baseUrl + endpoint) else { throw URLError(.badURL) }
    
    do{
      let contents = try await urlSession.data(from: url)
      guard let urlResponse = contents.1 as? HTTPURLResponse, urlResponse.statusCode == 200 else { throw ApiError.returnCodeNotValid }
      let decodedData = try decoder.decode([CoinModel].self, from: contents.0)
      return decodedData
    }catch{
      throw error
    }
  }
  
}
