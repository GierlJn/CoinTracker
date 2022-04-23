//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import SwiftUI

struct CoinRowView: View {
  
  var coin: CoinModel
  var showHoldings: Bool
  
    var body: some View {
      HStack{
        Text("\(coin.rank)")
        CoinImageView(coin: coin)
          .frame(width: 20, height: 20)
        
        
        Text(coin.name)
        Spacer()
        if showHoldings{
          VStack{
            Text("\(coin.currentHoldingsValue.asUsd2Decimal())")
            Text("\(coin.wrappedCurrentHoldings.asNumberString())")
          }
        }
        Spacer()
        VStack(alignment: .trailing){
          Text("\(coin.wrappedCurrentPrice.asUsd2Decimal())")
          Text("\(coin.wrappedPriceChangePercentage24H.asPercentString())")
        }
      }
      .background{
        Color.colorTheme.background.opacity(0.001)
      }
      .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
      Group{
        CoinRowView(coin: CoinModel.mockData, showHoldings: true)
          .previewLayout(.sizeThatFits)
          
        CoinRowView(coin: CoinModel.mockData, showHoldings: true)
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
      
    }
}
