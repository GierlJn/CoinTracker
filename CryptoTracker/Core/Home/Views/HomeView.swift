//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 14.04.22.
//

import SwiftUI

struct HomeView: View {
  
  @EnvironmentObject private var viewModel: HomeViewModel
  
  var body: some View {
    ZStack{
      Color.colorTheme.background
        .ignoresSafeArea()
      
      VStack{
        headerView
        SearchBarView(input: $viewModel.searchText)
        
        columnTitles
        if viewModel.showPortfolio{
          portfolioCoinsList
        }else{
          allCoinsList
        }
        Spacer()
      }
//      .task {
//        await viewModel.fetchAllCoins()
//      }
    }
  }
}

extension HomeView{
  var headerView: some View{
    HStack{
      CircleButtonView(iconName: viewModel.showPortfolio ? "plus" : "info")
        .background{
          CircleButtonAnimationView(animate: $viewModel.showPortfolio)
        }
      Spacer()
      Text(viewModel.showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.colorTheme.accent)
        .animation(.none)
      Spacer()
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: viewModel.showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()){
            viewModel.showPortfolio.toggle()
          }
        }
        .padding(.horizontal)
    }
  }
  
  var allCoinsList: some View{
    List(viewModel.allCoins){ coin in
      CoinRowView(coin: coin, showHoldings: false)
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
        .task{
          if coin == viewModel.allCoins.last{
            //await viewModel.fetchAllCoins()
          }
        }
    }
    .listStyle(PlainListStyle())
    .transition(.move(edge: .trailing))
  }
  
  var portfolioCoinsList: some View{
    List(viewModel.portfolioCoins){ coin in
      CoinRowView(coin: coin, showHoldings: false)
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
        .task{
          if coin == viewModel.allCoins.last{
            //await viewModel.fetchAllCoins()
          }
        }
    }
    .listStyle(PlainListStyle())
    .transition(.move(edge: .leading))
  }
  
  var columnTitles: some View{
    HStack{
      Text("Coins")
      Spacer()
      if viewModel.showPortfolio{
        Text("Holdings")
      }
      Spacer()
      Text("Price")
    }
    .foregroundColor(Color.colorTheme.secondaryText)
    .font(.caption)
    .padding(.horizontal)
  }
}

//struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//      HomeView()
//        .navigationBarHidden(true)
//        .environmentObject(HomeViewModel())
//  }
//}
