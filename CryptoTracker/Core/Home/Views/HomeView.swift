//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 14.04.22.
//

import SwiftUI

struct HomeView: View {
  
  @EnvironmentObject private var vm: HomeViewModel
  @State var showsPortfolioView = false
  
  var body: some View {
    ZStack{
      Color.colorTheme.background
        .ignoresSafeArea()
      
      VStack{
        headerView
        HomeStatsView()
        SearchBarView(input: $vm.searchText)
          .padding()
        columnTitles
        if vm.showPortfolio{
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
    
    .refreshable {
      vm.updateCoins()
    }
    
    .sheet(isPresented: $showsPortfolioView) {
      PortfolioView().environmentObject(vm)
    }
  }
}

extension HomeView{
  var headerView: some View{
    HStack{
      Button {
        if vm.showPortfolio{ showsPortfolioView = true }
      } label: {
        CircleButtonView(iconName: vm.showPortfolio ? "plus" : "info")
          .background{
            CircleButtonAnimationView(animate: $vm.showPortfolio)
          }
      }
      Spacer()
      Text(vm.showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.colorTheme.accent)
        .animation(.none)
      Spacer()
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: vm.showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()){
            vm.showPortfolio.toggle()
          }
        }
        .padding(.horizontal)
    }
  }
  
  var allCoinsList: some View{
    List(vm.allCoins){ coin in
      CoinRowView(coin: coin, showHoldings: false)
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
        .task{
          if coin == vm.allCoins.last{
            //await viewModel.fetchAllCoins()
          }
        }
    }
    .listStyle(PlainListStyle())
    .transition(.move(edge: .trailing))
  }
  
  var portfolioCoinsList: some View{
    List(vm.portfolioCoins){ coin in
      CoinRowView(coin: coin, showHoldings: true)
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
        .task{
          if coin == vm.allCoins.last{
            //await viewModel.fetchAllCoins()
          }
        }
    }
    .listStyle(PlainListStyle())
    .transition(.move(edge: .leading))
  }
  
  var columnTitles: some View{
    HStack{
      Button {
        vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
        }
       label: {
        Text("Coins")
      }
      .tint(Color.colorTheme.accent)

      
      Spacer()
      if vm.showPortfolio{
        Button {
          vm.sortOption = vm.sortOption == .holding ? .holdingReversed : .holding
          }
         label: {
          Text("Holdings")
        }
        .tint(Color.colorTheme.accent)
      }
      Spacer()
      Button {
        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
        }
       label: {
        Text("Price")
      }
      .tint(Color.colorTheme.accent)
    }
    .foregroundColor(Color.colorTheme.secondaryText)
    .font(.caption)
    .padding(.horizontal)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
      HomeView()
        .navigationBarHidden(true)
        .environmentObject(HomeViewModel())
  }
}
