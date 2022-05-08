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
  
  @StateObject private var vm: CoinDetailViewModel
  
  init(coin: CoinModel){
    _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
  }
  var body: some View{
    VStack{
      
      Text(vm.links?.subredditURL ?? "reddit N/A")
    }
  }
}

struct DetailLoadingView_Previews: PreviewProvider {
    static var previews: some View {
      DetailView(coin: CoinModel.mockData)
    }
}
