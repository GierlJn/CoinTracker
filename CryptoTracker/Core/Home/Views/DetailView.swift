//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 22.04.22.
//

import SwiftUI

struct DetailView: View {
  let coin: CoinModel?
    var body: some View {
      Text(coin?.name ?? "")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
      DetailView(coin: CoinModel.mockData)
    }
}
