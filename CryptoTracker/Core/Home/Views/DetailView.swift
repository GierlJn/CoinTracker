//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 22.04.22.
//

import SwiftUI

struct DetailLoadingView: View {
  
  @Binding var coin: CoinModel?
  
    var body: some View {
      ZStack{
        if let coin = coin{
          DetailView(coin: coin)
        }
      }
    }
}

struct DetailView: View{
  
  let coin: CoinModel
  
  var body: some View{
    Text(coin.name)
  }
}

struct DetailLoadingView_Previews: PreviewProvider {
    static var previews: some View {
      DetailView(coin: CoinModel.mockData)
    }
}
